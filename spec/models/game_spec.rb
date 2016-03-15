require 'rails_helper'

RSpec.describe Game, type: :model do
  context "when I create a new game" do
    context "with no arguments" do
      subject(:game) { Game.new }

      describe "#score" do
        it "should be set" do
          expect(game.score).not_to be_nil
        end
      end
    end
  end
end
