require 'rails_helper'
require 'capybara/rspec'

TESTING_WORD = "powershop"
STARTING_LIVES = 10
VALID_GUESSES = TESTING_WORD.chars.uniq
INVALID_GUESSES = (("a".."z").to_a - VALID_GUESSES)

LIVES_REMAINING_SELECTOR = "#livesremaining"
GUESSED_WORD_SELECTOR    = "#guessed_word"
GUESSES_SELECTOR         = "#guesses"
FINISHED_STATE_SELECTOR  = "#finishedstate"

LIVES_REMAINING_SINGULAR_REGEX = /\AYou have (?<lives>1) life remaining\z/
LIVES_REMAINING_PLURAL_REGEX   = /\AYou have (?<lives>\d+) lives remaining\z/
LIVES_REMAINING_REGEX = Regexp.union(LIVES_REMAINING_SINGULAR_REGEX,
                                     LIVES_REMAINING_PLURAL_REGEX)

GUESSED_WORD_REGEX = /\ACurrently guessed word is:(.*)\z/
GUESSES_REGEX      = /\AYou have guessed:(.*)\z/

def find(selector)
  Capybara.string(rendered).find(selector).text.strip
end

def lives_remaining
  find(LIVES_REMAINING_SELECTOR).match(LIVES_REMAINING_REGEX)[:lives].to_i
end

def guessed_word_array
  find(GUESSED_WORD_SELECTOR).match(GUESSED_WORD_REGEX)[1]
                             .gsub(/ /, '')
                             .chars.map { |character| character unless character == '_' }
end

def guesses
  find(GUESSES_SELECTOR).match(GUESSES_REGEX)[1]
                        .gsub(/ /, '')
                        .chars
end

def finished_state
  find(FINISHED_STATE_SELECTOR)
end

def make_correct_guess(game)
  guess = (VALID_GUESSES - game.guessed_letters).sample
  SubmitGuess.new(game, guess).call
end

def make_incorrect_guess(game)
  guess = (INVALID_GUESSES - game.guessed_letters).sample
  SubmitGuess.new(game, guess).call
end

RSpec.describe "games/show", type: :view do
  let(:word) { "hangman" }
  let(:new_game) { Game.create!(word: TESTING_WORD) }

  before do
    @game = assign(:game, game)
    render
  end

  context "with a new game" do
    let(:game) { new_game }

    it "should show #{STARTING_LIVES} lives remaining" do
      expect(lives_remaining).to be STARTING_LIVES
    end

    it "should have an empty guessed word" do
      expect(guessed_word_array.compact).to be_empty
    end

    it "should not have any guesses" do
      expect(guesses).to be_empty
    end

    it "should not be finished" do
      expect(finished_state).to be_empty
    end
  end

  context "with a game with 2 live remaining" do
    let(:game) do
      new_game.tap do |game|
        (STARTING_LIVES - 2).times { make_incorrect_guess(game) }
      end
    end

    it "should display lives remaining as plural 2 life" do
      expect(find(LIVES_REMAINING_SELECTOR)).to match LIVES_REMAINING_PLURAL_REGEX
      expect(lives_remaining).to be 2
    end
  end

  context "with a game with 1 live remaining" do
    let(:game) do
      new_game.tap do |game|
        (STARTING_LIVES - 1).times { make_incorrect_guess(game) }
      end
    end

    it "should display lives remaining as singluar 1 life" do
      expect(find(LIVES_REMAINING_SELECTOR)).to match LIVES_REMAINING_SINGULAR_REGEX
      expect(lives_remaining).to be 1
    end
  end

  context "with a finished game" do
    context "that is won" do
      let(:game) do
        new_game.tap do |game|
          STARTING_LIVES.times { make_correct_guess(game) }
        end
      end

      it "should display a finished state" do
        expect(finished_state).to include("GAME OVER")
      end

      it "should display a winning message" do
        expect(finished_state).to include("You won")
      end
    end

    context "that is lost" do
      let(:game) do
        new_game.tap do |game|
          STARTING_LIVES.times { make_incorrect_guess(game) }
        end
      end

      it "should display a finished state" do
        expect(finished_state).not_to be_empty
      end

      it "should display a losing message" do
        expect(finished_state).to include("You lost")
      end

      it "should display lives remaining as plural 0 lives" do
        expect(find(LIVES_REMAINING_SELECTOR)).to match LIVES_REMAINING_PLURAL_REGEX
        expect(lives_remaining).to be 0
      end
    end
  end

  pending "TODO: Add tests for showing errors on invalid guess"
end
