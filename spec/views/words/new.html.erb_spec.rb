require 'rails_helper'

RSpec.describe "words/new", type: :view do
  let(:word_list) { WordList.create!(
      :name => "MyString"
    )
  }
  before(:each) do
    assign(:word_list, word_list)
    assign(:word, word_list.words.new(
      :word => "MyString"
    ))
  end

  it "renders new word form" do
    render

    assert_select "form[action=?][method=?]", word_list_words_path(word_list), "post" do

      assert_select "input#word_word[name=?]", "word[word]"
    end
  end
end
