require "rails_helper"

RSpec.describe GuessesController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/games/:game_id/guesses").to route_to("guesses#create", game_id: ":game_id")
    end
  end
end
