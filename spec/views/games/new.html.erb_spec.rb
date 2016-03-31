require 'rails_helper'

RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:game, Game.new())
  end

  it "renders new game form" do
    # TODO we don't display a form anymore
    pending "TODO we don't display a form anymore"
    render

    assert_select "form[action=?][method=?]", games_path, "post" do
    end
  end
end
