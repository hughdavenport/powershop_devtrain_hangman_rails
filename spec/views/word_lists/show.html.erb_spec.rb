require 'rails_helper'

RSpec.describe "word_lists/show", type: :view do
  before(:each) do
    @word_list = assign(:word_list, WordList.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
