require 'rails_helper'

RSpec.describe Game, type: :model do
  context "when I create a new game" do
    context "with no arguments" do
      subject(:game) { Game.new }
      let(:default_starting_score) { 10 }

      describe "#score" do
        it "should be set" do
          expect(game.score).not_to be_nil
        end

        it "should be the default" do
          expect(game.score).to be default_starting_score
        end
      end
    end
  end
end
