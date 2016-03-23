require 'rails_helper'

RSpec.describe Game, type: :model do
  context "when I create a new game" do
    context "with no arguments" do
      subject(:game) { Game.new }
      let(:default_starting_score) { 10 }
      let(:default_word)           { "hangman" }

      describe "the game" do
        it { is_expected.not_to be_won }
        it { is_expected.not_to be_lost }
        it { is_expected.not_to be_finished }
      end

      describe "#lives" do
        subject { game.lives }

        it "should be the default" do
          is_expected.to eql default_starting_score
        end
      end

      describe "#word" do
        subject { game.word }

        it "should be the default" do
          is_expected.to eql default_word
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
      subject(:game) { Game.new(word: argument) }

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

      describe "#lives" do
        subject { game.lives }

        it "should be the same as the argument" do
          is_expected.to eql argument
        end
      end
    end
  end

  context "when I have a new game with 1 life left" do
    subject(:game) { Game.new(word: word, starting_score: 1) }
    let(:word) { "hangman" }

    context "and I make an incorrect guess" do
      let(:guess) { 'z' }
      before { game.submit_guess(guess) }

      describe "the game" do
        it { is_expected.not_to be_won }
        it { is_expected.to be_lost }
        it { is_expected.to be_finished }
      end

      describe "#lives" do
        subject { game.lives }

        it { is_expected.to be 0 }
      end
    end

    context "and I made a correct guess" do
      let(:guess) { 'a' }
      before { game.submit_guess(guess) }

      describe "the game" do
        it { is_expected.not_to be_won }
        it { is_expected.not_to be_lost }
        it { is_expected.not_to be_finished }
      end

      describe "#lives" do
        subject { game.lives }

        it { is_expected.to be 1 }
      end
    end
  end

  context "when I have a game with the word almost guessed and three incorrect guesses" do
    subject(:game) { Game.new(word: word) }
    let(:word) { "hangman" }
    let(:guesses) { ["e", "g", "m", "s", "n", "h", "r"] }
    before { guesses.each { |guess| game.submit_guess(guess) } }

    context "and I make an incorrect guess" do
      let(:guess) { 'z' }
      before { game.submit_guess(guess) }

      describe "the game" do
        it { is_expected.not_to be_won }
        it { is_expected.not_to be_lost }
        it { is_expected.not_to be_finished }
      end

      describe "#lives" do
        subject { game.lives }

        it { is_expected.to be 6 }
      end
    end

    context "and I made a correct guess" do
      let(:guess) { 'a' }
      before { game.submit_guess(guess) }

      describe "the game" do
        it { is_expected.to be_won }
        it { is_expected.not_to be_lost }
        it { is_expected.to be_finished }
      end

      describe "#lives" do
        subject { game.lives }

        it { is_expected.to be 7 }
      end
    end
  end

  context "when I have a game that has made a correct guess" do
    subject(:game) { Game.new(word: word) }
    let(:word) { "hangman" }
    let(:guess) { 'a' }
    before { game.submit_guess(guess) }

    describe "making the same guess" do
      subject { game.submit_guess(guess) }

      it "should not be allowed" do
        expect(subject).to be false
      end
    end
  end

  context "when I have a game that has made an incorrect guess" do
    subject(:game) { Game.new(word: word) }
    let(:word) { "hangman" }
    let(:guess) { 'z' }
    before { game.submit_guess(guess) }

    describe "making the same guess" do
      subject { game.submit_guess(guess) }

      it "should not be allowed" do
        expect(subject).to be false
      end
    end
  end
end
