require 'rails_helper'

RSpec.describe WordList, type: :model do
  let(:name) { "testing" }

  context "when I create a new wordlist" do
    subject(:wordlist) { WordList.create!(name: name) }

    describe "#name" do
      subject { wordlist.name }

      it { is_expected.to eql name }
    end
  end
end
