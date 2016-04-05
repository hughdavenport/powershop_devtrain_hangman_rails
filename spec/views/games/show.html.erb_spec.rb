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

def finished
  find('#finishedstate')
end

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!())
  end

  it "renders attributes in <p>" do
    render
  end

  context "with a new game" do
    before { @game = assign(:game, Game.create!()) }

    it "should show 10 lives left" do
      render

      expect(lives_left).to be 10
    end

    it "should have an empty guessed word" do
      render

      expect(guessed_word.compact).to be_empty
    end

    it "should not have any guesses" do
      render

      expect(guesses).to be_empty
    end

    it "should not be finished" do
      render

      expect(finished).to be_empty
    end
  end
end
