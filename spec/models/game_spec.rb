require 'rails_helper'

RSpec.describe Game, type: :model do
  context "when I create a new game" do
    context "with no arguments" do
      subject(:game) { Game.new }
      let(:default_starting_score) { 10 }
      let(:default_starting_word)  { "hangman" }

      describe "#score" do
        it "should be set" do
          expect(game.score).not_to be_nil
        end

        it "should be the default" do
          expect(game.score).to eql default_starting_score
        end
      end

      describe "#word" do
        it "should be set" do
          expect(game.word).not_to be_nil
        end

        it "should be the default" do
          expect(game.word).to eql default_starting_word
        end
      end
    end
  end
end
