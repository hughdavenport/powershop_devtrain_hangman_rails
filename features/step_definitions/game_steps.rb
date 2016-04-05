TESTING_WORD = "powershop"
STARTING_LIVES = 10
VALID_GUESSES = TESTING_WORD.chars.uniq
INVALID_GUESSES = (("a".."z").to_a - VALID_GUESSES)

LIVES_LEFT_SELECTOR     = "#livesleft"
GUESSED_WORD_SELECTOR   = "#guessed_word"
GUESSES_SELECTOR        = "#guesses"

LIVES_LEFT_SINGULAR_REGEX = /\AYou have (?<lives>1) life left\z/
LIVES_LEFT_MULTIPLE_REGEX = /\AYou have (?<lives>\d+) lives left\z/
LIVES_LEFT_REGEX = Regexp.union(LIVES_LEFT_SINGULAR_REGEX,
                                LIVES_LEFT_MULTIPLE_REGEX)

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

Given(/^I have almost won a game$/) do
  step "I have a new game"
  step "I make #{VALID_GUESSES.count - 1} valid guesses"
  @lives = @game.lives
end

Given(/^I have almost lost a game$/) do
  step "I have a new game"
  step "I make #{@lives - 1} invalid guesses"
  @lives = @game.lives
end


When(/^I make a(n)? (in)?valid guess$/) do |plural_to_ignore, invalid|
  @guess = ((invalid ? INVALID_GUESSES : VALID_GUESSES) - @game.guesses_array).sample
  fill_in "guess[guess]", :with => @guess
  click_on "Submit guess"
end

When(/^I make (\d+) (in)?valid guesses$/) do |number, invalid|
  number.to_i.times { step "I make a #{invalid}valid guess" }
end


Then(/^I should see my guess$/) do
  within(GUESSES_SELECTOR) { expect(page).to have_content(/^.*: ([a-z] )*#{@guess}( [a-z])*$/) }
end

Then(/^I should have (no|\d+) (in)?correct guess(es)?$/) do |number, incorrect, plural_to_ignore|
  number = 0 if number == "no"
  correct_guesses = find(GUESSED_WORD_SELECTOR).text
                                               .gsub(/^.*:/, '')
                                               .gsub(/[ _]/, '')
                                               .chars.uniq
  if incorrect
    all_guesses = find(GUESSES_SELECTOR).text
                                        .gsub(/^.*:/, '')
                                        .gsub(/ /, '')
                                        .chars.uniq
    test = (all_guesses - correct_guesses).count
  else
    test = correct_guesses.count
  end
  expect(test).to be number.to_i
end

Then(/^I should have lost (no|\d+)? (more )?li(ves|fe)$/) do |number, more_to_ignore, plural_to_ignore|
  number = 0 if number == "no"
  lives = find(LIVES_LEFT_SELECTOR).text.gsub(LIVES_LEFT_REGEX, '\\k<lives>').to_i
  expect(lives).to be (@lives - number.to_i)
end

Then(/^I should (not )?have (won|lost) the game$/) do |negation, state|
  if negation
    expect(page).not_to have_content(/You #{state}/)
  else
    expect(page).to have_content(/You #{state}/)
  end
end
