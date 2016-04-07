require 'rails_helper'

RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:game, Game.new())
  end

  it "renders new game form" do
    render

    assert_select "form[action=?][method=?]", games_path, "post" do
    end
  end

  it "has a field for starting lives" do
    render

    assert_select "form input#game_starting_lives"
  end
  pending "TODO add tests for showing errors on creating a game"
end
