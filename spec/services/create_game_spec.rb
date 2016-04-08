require 'rails_helper'

RSpec.describe CreateGame, type: :service do
  before { CreateWordList.new(word_list, word_list_words).call }
  after { WordList.destroy_all }

  let(:word_list) { "default" }
  let(:word_list_words) { ["testing"] }

  subject(:service) { CreateGame.new(starting_lives, word_list) }

  context "with a valid starting lives parameter" do
    let(:starting_lives) { 10 }

    it "succeeds" do
      expect(service.call).to be_truthy
    end

    it "adds another game" do
      expect { service.call }.to change(Game, :count).by(1)
    end

    it "has the correct starting lives in created game" do
      service.call
      expect(Game.last.starting_lives).to eql starting_lives
    end

    it "returns a game object" do
      expect(service.call).to be_a(Game)
    end

    it "has the game use a word from the wordlist supplied" do
      service.call
      expect(word_list_words).to include(Game.last.word)
    end

    it "has no errors" do
      service.call
      expect(service.errors).to be_empty
    end
  end

  describe "with an invalid starting lives paramter" do
    context "of a negative number" do
      let(:starting_lives) { -1 }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another game" do
        expect { service.call }.not_to change(Game, :count)
      end

      it "has a copy of the invalid game" do
        service.call
        expect(service.game).to be_a(Game)
        expect(service.game).not_to be_persisted
      end

      it "has errors" do
        service.call
        expect(service.errors).not_to be_empty
      end
    end

    context "of a floating point number" do
      let(:starting_lives) { 1.5 }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another game" do
        expect { service.call }.not_to change(Game, :count)
      end

      it "has a copy of the invalid game" do
        service.call
        expect(service.game).to be_a(Game)
        expect(service.game).not_to be_persisted
      end

      it "has errors" do
        service.call
        expect(service.errors).not_to be_empty
      end
    end

    context "of a non number" do
      let(:starting_lives) { "a" }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another game" do
        expect { service.call }.not_to change(Game, :count)
      end

      it "has a copy of the invalid game" do
        service.call
        expect(service.game).to be_a(Game)
        expect(service.game).not_to be_persisted
      end

      it "has errors" do
        service.call
        expect(service.errors).not_to be_empty
      end
    end
  end
end
