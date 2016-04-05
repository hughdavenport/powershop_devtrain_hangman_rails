require 'rails_helper'
require 'capybara/rspec'

LIVES_LEFT_REGEX   = /\AYou have (\d+) lives left\z/
GUESSED_WORD_REGEX = /\ACurrently guessed word is:(.*)\z/
GUESSES_REGEX      = /\AYou have guessed:(.*)\z/

def find(selector)
  Capybara.string(rendered).find(selector).text.strip
end

def lives_left
  find('#livesleft').match(LIVES_LEFT_REGEX)[1].to_i
end

def guessed_word
  find('#guessed_word').match(GUESSED_WORD_REGEX)[1]
                       .gsub(/ /, '')
                       .chars.map { |character| character unless character == '_' }
end

def guesses
  find('#guesses').match(GUESSES_REGEX)[1]
                  .gsub(/ /, '')
                  .chars
end

def finished_state
  find('#finishedstate')
end

RSpec.describe "games/show", type: :view do
  let(:word) { "hangman" }

  let(:new_game) { Game.create!(word: word) }

  let(:won_game) do
    new_game.tap do |game|
      word.chars.each { |guess| game.submit_guess(guess) }
    end
  end

  let(:lost_game) do
    new_game.tap do |game|
      (('a'..'z').to_a - word.chars).sample(10).each { |guess| game.submit_guess(guess) }
    end
  end

  context "with a new game" do
    before do
      @game = assign(:game, new_game)
      render
    end

    it "should show 10 lives left" do
      expect(lives_left).to be 10
    end

    it "should have an empty guessed word" do
      expect(guessed_word.compact).to be_empty
    end

    it "should not have any guesses" do
      expect(guesses).to be_empty
    end

    it "should not be finished" do
      expect(finished_state).to be_empty
    end
  end

  context "with a finished game" do
    context "that is won" do
      before do
        @game = assign(:game, won_game)
        render
      end

      it "should display a finished state" do
        expect(finished_state).to include("GAME OVER")
      end

      it "should display a winning message" do
        expect(finished_state).to include("You won")
      end
    end

    context "that is lost" do
      before do
        @game = assign(:game, lost_game)
        render
      end

      it "should display a finished state" do
        expect(finished_state).not_to be_empty
      end

      it "should display a losing message" do
        expect(finished_state).to include("You lost")
      end
    end
  end
end
