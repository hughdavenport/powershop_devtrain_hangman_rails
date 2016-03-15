require 'rails_helper'

RSpec.describe Game, type: :model do
  context "when I create a new game" do
    context "with no arguments" do
      subject(:game) { Game.new }
      let(:default_starting_score) { 10 }
      let(:default_starting_word)  { "hangman" }

      describe "the game" do
        it { is_expected.not_to be_won }
        it { is_expected.not_to be_lost }
        it { is_expected.not_to be_finished }
      end

      describe "#score" do
        subject { game.score }

        it "should be set" do
          is_expected.not_to be_nil
        end

        it "should be the default" do
          is_expected.to eql default_starting_score
        end
      end

      describe "#word" do
        subject { game.word }

        it "should be set" do
          is_expected.not_to be_nil
        end

        it "should be the default" do
          is_expected.to eql default_starting_word
        end
      end

      describe "#word_guessed_so_far" do
        subject { game.word_guessed_so_far}

        it "should be empty" do
          expect(subject.compact).to be_empty
        end
      end
    end

    context "with an argument for the starting word" do
      let(:argument) { "testing" }
      subject(:game) { Game.new(starting_word: argument) }

      describe "#word" do
        subject { game.word }

        it "should be the same as the argument" do
          is_expected.to eql argument
        end
      end
    end

    context "with an argument for the starting score" do
      let(:argument) { 1 }
      subject(:game) { Game.new(starting_score: argument) }

      describe "#score" do
        subject { game.score }

        it "should be the same as the argument" do
          is_expected.to eql argument
        end
      end
    end
  end
end
