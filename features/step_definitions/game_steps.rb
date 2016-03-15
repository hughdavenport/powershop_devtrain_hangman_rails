Given(/^I start a new game of hangman$/) do
  @game = Game.new
end

Then(/^the score should be set$/) do
  expect(@game.score).not_to be nil
end
