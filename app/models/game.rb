class Game < ActiveRecord::Base
  attr_reader :score

  DEFAULT_STARTING_SCORE = 10

  def initialize(starting_score: DEFAULT_STARTING_SCORE)
    @score = starting_score
  end
end
