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
end
