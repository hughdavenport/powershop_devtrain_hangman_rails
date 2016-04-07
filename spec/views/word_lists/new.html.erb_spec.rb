require 'rails_helper'

RSpec.describe "word_lists/new", type: :view do
  before(:each) do
    assign(:word_list, WordList.new(
      :name => "MyString"
    ))
  end

  it "renders new word_list form" do
    render

    assert_select "form[action=?][method=?]", word_lists_path, "post" do

      assert_select "input#word_list_name[name=?]", "word_list[name]"
    end
  end
end
