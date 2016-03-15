DEFAULT_STARTING_SCORE = 10
DEFAULT_STARTING_WORD  = "hangman"

Given(/^I start a new game of hangman$/) do
  @game = Game.new
end

Given(/^I start a new game of hangman with starting word of (.*)$/) do |value|
  @argument = value
  @game     = Game.new(starting_word: @argument)
end

Given(/^I start a new game of hangman with starting score of (.*)$/) do |value|
  @argument = value.to_i
  @game     = Game.new(starting_score: @argument)
end

When(/^I make an incorrect guess$/) do
  guess = 'z' # Assuming default word of hangman
  step "I make a guess of #{guess}"
end

When(/^I make a correct guess$/) do
  guess = 'a' # Assuming default word of hangman
  step "I make a guess of #{guess}"
end

When(/^I make a guess of (.)$/) do |guess|
  @game.submit_guess(guess)
end

Then(/^the (.*) should be set$/) do |field|
  expect(@game.send(field.gsub(/ /, "_"))).not_to be_nil
end

Then(/^the (.*) should be the default$/) do |field|
  expect(@game.send(field.gsub(/ /, "_"))).to eql Object.const_get("DEFAULT_STARTING_#{field.upcase}")
end

Then(/^the (.*) should be the same as the argument$/) do |field|
  expect(@game.send(field.gsub(/ /, "_"))).to eql @argument
end

Then(/^the (.*) should be empty$/) do |field|
  expect(@game.send(field.gsub(/ /, "_")).compact).to be_empty
end

Then(/^the score should be (\d+)$/) do |score|
  expect(@game.score).to eql score.to_i
end

Then(/^I should(( not)?) have (.*) the game$/) do |negation, ignore, method|
  expectation = expect(@game.send("#{method}?"))
  if negation.empty?
    expectation.to be true
  else
    expectation.to be false
  end
end
