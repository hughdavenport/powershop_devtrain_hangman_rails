require 'rails_helper'

RSpec.describe SubmitGuess, type: :service do
  let(:word) { "hangman" }
  let(:game_params) { { word: word } }

  let(:game) { Game.create!(game_params) }

  subject(:submit_guess) { SubmitGuess.new(game, letter) }

  context "making a valid guess" do
    let(:letter) { "a" }

    it "returns true" do
      expect(submit_guess.call).to be true
      # todo check actually saves
      # expect .to_change
      # .last
    end

    it "has no errors" do
      submit_guess.call
      expect(submit_guess.errors).to be_empty
    end
  end

  context "making an invalid guess" do
    let(:letter) { "!" }

    it "returns false" do
      expect(submit_guess.call).to be false
      # negate all comments :)
      # todo check actually saves
      # expect .to_change
      # .last
    end

    it "has errors" do
      submit_guess.call
      expect(submit_guess.errors).not_to be_empty
    end
  end

  context "when I have a game that has made a guess" do
    before { SubmitGuess.new(game, letter).call }

    context "that is correct" do
      let(:letter) { 'a' }

      describe "making the same guess" do
        it "returns false" do
          expect(submit_guess.call).to be false
        end

        it "has errors" do
          submit_guess.call
          expect(submit_guess.errors).not_to be_empty
        end
      end
    end

    context "that is incorrect" do
      let(:letter) { 'z' }

      describe "making the same guess" do
        it "returns false" do
          expect(submit_guess.call).to be false
        end

        it "has errors" do
          submit_guess.call
          expect(submit_guess.errors).not_to be_empty
        end
      end
    end
  end
end
