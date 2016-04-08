require 'rails_helper'

RSpec.describe "word_lists/index", type: :view do
  before(:each) do
    assign(:word_lists, [
      WordList.create!(
        :name => "Name"
      ),
      WordList.create!(
        :name => "Name2"
      )
    ])
  end

  it "renders a list of word_lists" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 1
    assert_select "tr>td", :text => "Name2".to_s, :count => 1
  end
end
