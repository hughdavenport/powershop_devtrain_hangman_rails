TESTING_NAME = "testing"
WORDS_SELECTOR = // # TODO get selector

Given(/^I see all the word lists$/) do
  step 'I see the home page'
  step 'I click "Word Lists"'
end

Given(/^I have a word list with no words$/) do
  @word_list = WordList.create!(name: TESTING_NAME)
  @word_count = @word_list.words.count
  visit url_for(@word_list)
end

Given(/^I have a word list with some words$/) do
  step "I have a word list with no words"
  3.times { step "I enter in a word" }
  @word_count = @word_list.words.count
end


When(/^I enter in a word$/) do
  step "I enter #{@word} as the last word" # TODO define "last word"
end


Then(/^I should (not )?see the word$/) do |negation|
  if negation
    within(WORDS_SELECTOR) { expect(page).not_to have_content(/^#{@guess}$/) }
  else
    within(WORDS_SELECTOR) { expect(page).to have_content(/^#{@guess}$/) }
  end
end

Then(/^I should see (no|\d+) ((more|less) )?word(s)?$/) do |number, more_or_less_to_ignore, more_or_less, plural_to_ignore|
  number = 0 if number == "no"
  base_comparison = (more_or_less ? @word_count : 0)
  multiplier = (more_or_less == "less" ? -1 : 1)
  words = find(WORDS_SELECTOR)
  expect(words.length).to be (base_comparison + multiplier * number.to_i)
end

Then(/^I should not see the list that I deleted$/) do
  expect(page).not_to have_selector("table tbody tr td:first-child():contains('#{@word_list.name}')")
end
