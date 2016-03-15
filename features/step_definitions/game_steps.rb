DEFAULT_STARTING_SCORE = 10

Given(/^I start a new game of hangman$/) do
  @game = Game.new
end

Then(/^the score should be set$/) do
  expect(@game.score).not_to be nil
end

Then(/^the score should be the default$/) do
  expect(@game.score).to be DEFAULT_STARTING_SCORE
end
