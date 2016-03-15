class Game < ActiveRecord::Base
  attr_reader :score
  attr_reader :word

  DEFAULT_STARTING_SCORE = 10
  DEFAULT_STARTING_WORD  = "hangman"

  def initialize(starting_score: DEFAULT_STARTING_SCORE,
                 starting_word:  DEFAULT_STARTING_WORD)
    @score = starting_score
    @word  = starting_word
  end
end
