require 'rails_helper'

RSpec.describe CreateWordList, type: :service do
  subject(:service) { CreateWordList.new(name, words) }

  context "with a valid name and set of words" do
    let(:name) { "testing" }
    let(:words) { [
      "apple",
      "banana",
      "carrot",
    ] }

    it "succeeds" do
      expect(service.call).to be_truthy
    end

    it "adds another WordList" do
      expect { service.call }.to change(WordList, :count).by(1)
    end

    it "adds more words" do
      expect { service.call }.to change(Word, :count).by(words.count)
    end

    it "has the correct name in created wordlist" do
      service.call
      expect(WordList.last.name).to eql name
    end

    it "has the correct words in the created wordlist" do
      service.call
      expect(WordList.last.words.pluck(:word)).to eql words
    end

    it "returns a wordlist object" do
      expect(service.call).to be_a(WordList)
    end

    it "has no errors" do
      service.call
      expect(service.word_list.errors).to be_empty
    end
  end

  context "with an invalid name" do
    let(:name) { "" }
    let(:words) { [] }

    it "fails" do
      expect(service.call).to be_falsey
    end

    it "doesn't add another wordlist" do
      expect { service.call }.not_to change(WordList, :count)
    end

    it "has a copy of the invalid wordlist" do
      service.call
      expect(service.word_list).to be_a(WordList)
      expect(service.word_list).not_to be_persisted
    end

    it "has errors" do
      service.call
      expect(service.errors).not_to be_empty
    end
  end

  context "with a duplicate name" do
    let(:name) { "testing" }
    let(:words) { [] }

    before { CreateWordList.new(name, []).call }

    it "fails" do
      expect(service.call).to be_falsey
    end

    it "doesn't add another wordlist" do
      expect { service.call }.not_to change(WordList, :count)
    end

    it "has a copy of the invalid wordlist" do
      service.call
      expect(service.word_list).to be_a(WordList)
      expect(service.word_list).not_to be_persisted
    end

    it "has errors" do
      service.call
      expect(service.errors).not_to be_empty
    end
  end

  context "with invalid words" do
    let(:name) { "testing" }

    context "containing short words" do
      let(:words) { [ "valid", "ab", "another" ] }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another wordlist" do
        expect { service.call }.not_to change(WordList, :count)
      end

      it "doesn't add any words" do
        expect { service.call }.not_to change(Word, :count)
      end

      it "has a copy of the invalid wordlist" do
        service.call
        expect(service.word_list).to be_a(WordList)
        expect(service.word_list).not_to be_persisted
      end

      it "has errors" do
        service.call
        expect(service.errors).not_to be_empty
      end
    end

    context "containing too long words" do
      let(:words) { [ "valid", "waytoolongawordforhangman", "another" ] }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another wordlist" do
        expect { service.call }.not_to change(WordList, :count)
      end

      it "doesn't add any words" do
        expect { service.call }.not_to change(Word, :count)
      end

      it "has a copy of the invalid wordlist" do
        service.call
        expect(service.word_list).to be_a(WordList)
        expect(service.word_list).not_to be_persisted
      end

      it "has errors" do
        service.call
        expect(service.errors).not_to be_empty
      end
    end

    context "containing capital letters" do
      let(:words) { [ "valid", "Capital", "another" ] }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another wordlist" do
        expect { service.call }.not_to change(WordList, :count)
      end

      it "doesn't add any words" do
        expect { service.call }.not_to change(Word, :count)
      end

      it "has a copy of the invalid wordlist" do
        service.call
        expect(service.word_list).to be_a(WordList)
        expect(service.word_list).not_to be_persisted
      end

      it "has errors" do
        service.call
        expect(service.errors).not_to be_empty
      end
    end

  end
end
