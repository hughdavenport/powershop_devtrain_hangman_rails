require 'rails_helper'

RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:game, Game.new(
      :starting_lives => 5
    ))
    assign(:wordlists, WordList.all.pluck(:name))
  end

  it "renders new game form" do
    render

    assert_select "form[action=?][method=?]", games_path, "post" do

      assert_select "input#game_starting_lives[name=?]", "game[starting_lives]"
    end
  end

  pending "TODO add tests for showing errors on creating a game"
end
