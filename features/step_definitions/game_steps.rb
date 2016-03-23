TESTING_WORD = "powershop"
STARTING_LIVES = 10
VALID_GUESSES = TESTING_WORD.chars
INVALID_GUESSES = (("a".."z").to_a - VALID_GUESSES)

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

When(/^I make a(n)? (in)?valid guess$/) do |plural_to_ignore, invalid|
  @guess = ((invalid ? INVALID_GUESSES : VALID_GUESSES) - @game.guesses).sample
  fill_in "game[guess]", :with => @guess
  click_on "Submit guess"
end

Then(/^I should see my guess$/) do
  within("#guesses") { expect(page).to have_content(/^.*: ([a-z] )*#{@guess}([a-z] )*$/) }
end

Then(/^I should have (no|\d+) (in)?correct guess(es)?$/) do |number, incorrect, plural_to_ignore|
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

Then(/^I should have lost (no|\d+)? li(ves|fe)$/) do |number, plural_to_ignore|
  number = 0 if number == "no"
  lives = find('#livesleft').text.gsub(/^You have (\d+) lives left$/, '\\1').to_i
  expect(lives).to be (@lives - number.to_i)
end

When(/^I make (\d+) (in)?valid guesses$/) do |number, invalid|
  number.to_i.times { step "I make a #{invalid}valid guess" }
end
