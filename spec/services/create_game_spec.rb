require 'rails_helper'

RSpec.describe CreateGame, type: :service do

  subject(:service) { CreateGame.new(starting_lives) }

  context "with a valid starting lives parameter" do
    let(:starting_lives) { 10 }

    it "succeeds" do
      expect(service.call).to be_truthy
      # todo check actually saves
      # expect .to_change
      # .last
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

      it "has errors" do
        service.call
        expect(service.errors).not_to be_empty
      end
    end
  end
end
