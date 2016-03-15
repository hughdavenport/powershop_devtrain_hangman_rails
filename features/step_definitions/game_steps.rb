DEFAULT_STARTING_SCORE = 10
DEFAULT_STARTING_WORD  = "hangman"

Given(/^I start a new game of hangman$/) do
  @game = Game.new
end

Then(/^the (.*) should be set$/) do |field|
  expect(@game.send(field.gsub(/ /, "_"))).not_to be_nil
end

Then(/^the (.*) should be the default$/) do |field|
  expect(@game.send(field.gsub(/ /, "_"))).to eql Object.const_get("DEFAULT_STARTING_#{field.upcase}")
end

Then(/^the (.*) should be empty$/) do |field|
  expect(@game.send(field.gsub(/ /, "_")).compact).to be_empty
end
