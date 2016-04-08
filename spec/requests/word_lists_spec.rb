require 'rails_helper'

RSpec.describe "WordLists", type: :request do
  describe "GET /word_lists" do
    it "works! (now write some real specs)" do
      get word_lists_path
      expect(response).to have_http_status(200)
    end
  end
end
