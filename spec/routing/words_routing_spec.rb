require "rails_helper"

RSpec.describe WordsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/word_lists/:word_list_id/words/new").to route_to("words#new", :word_list_id => ":word_list_id")
    end

    it "routes to #create" do
      expect(:post => "/word_lists/:word_list_id/words").to route_to("words#create", :word_list_id => ":word_list_id")
    end

    it "routes to #destroy" do
      expect(:delete => "/word_lists/:word_list_id/words/1").to route_to("words#destroy", :word_list_id => ":word_list_id", :id => "1")
    end
  end
end
