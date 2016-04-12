require 'rails_helper'

RSpec.describe SubmitGuess, type: :service do
  let(:word) { "hangman" }
  let(:game_params) { { word: word }.merge(game_params_overridden) }
  let(:game_params_overridden) { {} }

  let(:game) { Game.create!(game_params) }

  subject(:service) { SubmitGuess.new(game, letter) }

  context "submitting a valid guess" do
    let(:letter) { "a" }

    it "succeeds" do
      expect(service.call).to be_truthy
    end

    it "adds another guess" do
      expect { service.call }.to change(Guess, :count).by(1)
    end

    it "adds the correct guess based on values" do
      service.call
      expect(Guess.last.guess).to eql letter
      expect(Guess.last.game).to eql game
    end

    it "has no errors" do
      service.call
      expect(service.errors).not_to be_present
    end
  end

  describe "submitting an invalid guess" do
    context "of a capital letter" do
      let(:letter) { 'A' }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another guess" do
        expect { service.call }.not_to change(Guess, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end

    context "of a digit" do
      let(:letter) { '1' }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another guess" do
        expect { service.call }.not_to change(Guess, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end

    context "of a non alpha-numeric character" do
      let(:letter) { "~" }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another guess" do
        expect { service.call }.not_to change(Guess, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end

    context "of an empty string" do
      let(:letter) { "" }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another guess" do
        expect { service.call }.not_to change(Guess, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end

    context "of a multicharacter string" do
      let(:letter) { "ab" }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another guess" do
        expect { service.call }.not_to change(Guess, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end

    context "of an empty array" do
      let(:letter) { [] }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another guess" do
        expect { service.call }.not_to change(Guess, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end

    context "of an single valid character array" do
      let(:letter) { ['a'] }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another guess" do
        expect { service.call }.not_to change(Guess, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end

    context "of an multiple character array" do
      let(:letter) { ['a', 'b'] }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another guess" do
        expect { service.call }.not_to change(Guess, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end
  end

  context "when I have a game that has one guess" do
    before { SubmitGuess.new(game, letter).call }

    context "that is correct" do
      let(:letter) { 'a' }

      describe "submitting the same guess" do
        it "fails" do
          expect(service.call).to be_falsey
        end

        it "doesn't add another guess" do
          expect { service.call }.not_to change(Guess, :count)
        end

        it "has errors" do
          service.call
          expect(service.errors).to be_present
        end
      end
    end

    context "that is incorrect" do
      let(:letter) { 'z' }

      describe "submitting the same guess" do
        it "fails" do
          expect(service.call).to be_falsey
        end

        it "doesn't add another guess" do
          expect { service.call }.not_to change(Guess, :count)
        end

        it "has errors" do
          service.call
          expect(service.errors).to be_present
        end
      end
    end
  end

  context "when I have a finished (lost) game" do
    let(:game_params_overridden) { { starting_lives: 0 } }

    describe "submitting a guess" do
      let(:letter) { 'a' }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another guess" do
        expect { service.call }.not_to change(Guess, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end
  end

  context "when I have a finished (won) game" do
    let(:letters) { word.chars.uniq }
    before { letters.each { |letter| SubmitGuess.new(game, letter).call } }

    describe "submitting a guess" do
      let(:letter) { 'z' }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another guess" do
        expect { service.call }.not_to change(Guess, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end
  end
end
