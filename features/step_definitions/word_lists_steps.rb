TESTING_NAME = "testing"
WORDS_SELECTOR = "table tbody tr td:first"

TESTING_WORDS = %w[alpha bravo charlie delta echo foxtrot golf hotel india juliet kilo llama mike]

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
  3.times { step "I add a word" }
  @word_count = @word_list.words.count
end


When(/^I add a word$/) do
  @word = (TESTING_WORDS - @word_list.words.pluck(:word)).sample
  step 'I click "Add Word"'
  step "I enter #{@word} as Word"
  step 'I click "Create Word"'
end

When(/^I delete a word$/) do
  step 'I click "Destroy" next to a word'
end


Then(/^I should see the word$/) do
  expect(page).to have_selector("#{WORDS_SELECTOR}:contains('#{@word}')")
end

Then(/^I should see (no|\d+) ((more|less) )?word(s)?$/) do |number, more_or_less_to_ignore, more_or_less, plural_to_ignore|
  number = 0 if number == "no"
  base_comparison = (more_or_less ? @word_count : 0)
  multiplier = (more_or_less == "less" ? -1 : 1)
  expect(page).to have_selector(WORDS_SELECTOR, count: (base_comparison + multiplier * number.to_i))
end
