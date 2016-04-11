require 'rails_helper'

RSpec.describe Game, type: :model do
  context "when I create a new game" do
    context "with an argument for the starting word" do
      let(:argument) { "testing" }
      let(:default_starting_lives) { 10 }
      subject(:game) { Game.create!(word: argument) }

      describe "the game" do
        it { is_expected.not_to be_won }
        it { is_expected.not_to be_lost }
        it { is_expected.not_to be_finished }
      end

      describe "#lives" do
        subject { game.lives }

        it "should be the default" do
          is_expected.to eql default_starting_lives
        end
      end

      describe "#word" do
        subject { game.word }

        it "should be the same as the argument" do
          is_expected.to eql argument
        end
      end

      describe "#word_guessed_so_far" do
        subject { game.word_guessed_so_far}

        it "should be empty" do
          expect(subject.compact).to be_empty
        end
      end

      context "and an argument for the starting score" do
        let(:argument2) { 1 }
        subject(:game) { Game.create!(word: argument, starting_lives: argument2) }

        describe "the game" do
          it { is_expected.not_to be_won }
          it { is_expected.not_to be_lost }
          it { is_expected.not_to be_finished }
        end

        describe "#lives" do
          subject { game.lives }

          it "should be the same as the argument" do
            is_expected.to eql argument2
          end
        end

        describe "#word" do
          subject { game.word }

          it "should be the same as the argument" do
            is_expected.to eql argument
          end
        end

        describe "#word_guessed_so_far" do
          subject { game.word_guessed_so_far}

          it "should be empty" do
            expect(subject.compact).to be_empty
          end
        end
      end
    end
  end

  context "when I have a new game with 1 life remaining" do
    subject(:game) { Game.create!(word: word, starting_lives: 1) }
    let(:word) { "hangman" }

    context "and I make an incorrect guess" do
      let(:letter) { 'z' }
      before { SubmitGuess.new(game, letter).call }

      describe "the game" do
        it { is_expected.not_to be_won }
        it { is_expected.to be_lost }
        it { is_expected.to be_finished }
      end

      describe "#lives" do
        subject { game.lives }

        it { is_expected.to be 0 }
      end

      describe "#incorrect_guesses" do
        subject { game.incorrect_guesses }

        it "should contain the guess" do
          expect(subject).to include(letter)
        end
      end

      describe "#correct_guesses" do
        subject { game.correct_guesses }

        it "should not contain the guess" do
          expect(subject).not_to include(letter)
        end
      end
    end

    context "and I made a correct guess" do
      let(:letter) { 'a' }
      before { SubmitGuess.new(game, letter).call }

      describe "the game" do
        it { is_expected.not_to be_won }
        it { is_expected.not_to be_lost }
        it { is_expected.not_to be_finished }
      end

      describe "#lives" do
        subject { game.lives }

        it { is_expected.to be 1 }
      end

      describe "#incorrect_guesses" do
        subject { game.incorrect_guesses }

        it "should not contain the guess" do
          expect(subject).not_to include(letter)
        end
      end

      describe "#correct_guesses" do
        subject { game.correct_guesses }

        it "should contain the guess" do
          expect(subject).to include(letter)
        end
      end
    end
  end

  context "when I have a game with the word almost guessed and three incorrect guesses" do
    subject(:game) { Game.create!(word: word) }
    let(:word) { "hangman" }
    let(:letters) { ["e", "g", "m", "s", "n", "h", "r"] }
    before { letters.each { |letter| expect(SubmitGuess.new(game, letter).call).to be true } }

    context "and I make an incorrect guess" do
      let(:letter) { 'z' }
      before { SubmitGuess.new(game, letter).call }

      describe "the game" do
        it { is_expected.not_to be_won }
        it { is_expected.not_to be_lost }
        it { is_expected.not_to be_finished }
      end

      describe "#lives" do
        subject { game.lives }

        it { is_expected.to be 6 }
      end

      describe "#incorrect_guesses" do
        subject { game.incorrect_guesses }

        it "should contain the guess" do
          expect(subject).to include(letter)
        end
      end

      describe "#correct_guesses" do
        subject { game.correct_guesses }

        it "should not contain the guess" do
          expect(subject).not_to include(letter)
        end
      end
    end

    context "and I made a correct guess" do
      let(:letter) { 'a' }
      before { SubmitGuess.new(game, letter).call }

      describe "the game" do
        it { is_expected.to be_won }
        it { is_expected.not_to be_lost }
        it { is_expected.to be_finished }
      end

      describe "#lives" do
        subject { game.lives }

        it { is_expected.to be 7 }
      end

      describe "#incorrect_guesses" do
        subject { game.incorrect_guesses }

        it "should not contain the guess" do
          expect(subject).not_to include(letter)
        end
      end

      describe "#correct_guesses" do
        subject { game.correct_guesses }

        it "should contain the guess" do
          expect(subject).to include(letter)
        end
      end
    end
  end
end
