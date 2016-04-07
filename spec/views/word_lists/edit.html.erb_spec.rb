require 'rails_helper'

RSpec.describe "word_lists/edit", type: :view do
  before(:each) do
    @word_list = assign(:word_list, WordList.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit word_list form" do
    render

    assert_select "form[action=?][method=?]", word_list_path(@word_list), "post" do

      assert_select "input#word_list_name[name=?]", "word_list[name]"
    end
  end
end
