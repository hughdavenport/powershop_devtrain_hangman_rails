TESTING_WORD = "powershop"
STARTING_LIVES = 10
VALID_GUESSES = TESTING_WORD.chars

When(/^I see the home page$/) do
  visit root_path
end

When(/^I click "([^"]*)"$/) do |link|
  click_on link
end

Then(/^I should see a new game$/) do
	expect(page).to have_content(/Game was successfully created./)
end

Given(/^I have a new game$/) do
  @game = Game.new(word: TESTING_WORD)
  @game.save
  @lives = @game.lives
  visit url_for(@game)
end

When(/^I make a valid guess$/) do
  @guess = (VALID_GUESSES - @game.guesses).sample
  fill_in "game[guess]", :with => @guess
  click_on "Submit guess"
end

Then(/^I should see my guess$/) do
  within("#guesses") { expect(page).to have_content(/^.*: ([a-z] )*#{@guess}([a-z] )*$/) }
end

Then(/^I should have (no|\d+) (in)?correct guess(es)?$/) do |number, incorrect, plural_to_ignore|
  pending if number != "no" and ! /^\d+$/.match(number)
  number = 0 if number == "no"
  correct_guesses = find('#guessed_word').text
                                         .gsub(/^.*:/, '')
                                         .gsub(/[ _]/, '')
                                         .chars.uniq
  if incorrect
    all_guesses = find('#guesses').text
                                 .gsub(/^.*:/, '')
                                 .gsub(/ /, '')
                                 .chars.uniq
    test = (all_guesses - correct_guesses).count
  else
    test = correct_guesses.count
  end
  expect(test).to be number.to_i
end

Then(/^I should not have lost lives$/) do
  within('#livesleft') { expect(page).to have_content(/^You have #{@lives} lives left$/) }
end
