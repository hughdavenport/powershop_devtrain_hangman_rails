require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the GamesHelper. For example:
#
# describe GamesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe GamesHelper, type: :helper do
  let(:word) { "hangman" }
  let(:game) { Game.create(word: word) }
  let(:guesses) { %w[h n m w p k] }
  before { guesses.each { |guess| SubmitGuess.new(game, guess).call } }

  describe "#guessed_word" do
    let(:wrong_letters) { word.chars - guesses }
    let(:regexp) { Regexp.new(wrong_letters.join('|')) }
    it "should have wrong letters displayed as ' _ '" do
      expect(helper.guessed_word(game)).to eq word.gsub(regexp, ' _ ')
    end
  end

  describe "#guessed_letters" do
    it "should have the guessed letters separated by spaces" do
      expect(helper.guessed_letters(game)).to eq guesses.join(" ")
    end
  end
end
