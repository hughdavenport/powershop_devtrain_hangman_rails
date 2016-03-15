class Game < ActiveRecord::Base
  attr_reader :score
  attr_reader :word
  attr_reader :guesses

  DEFAULT_STARTING_SCORE = 10
  DEFAULT_STARTING_WORD  = "hangman"

  def initialize(starting_score: DEFAULT_STARTING_SCORE,
                 starting_word:  DEFAULT_STARTING_WORD)
    @score   = starting_score
    @word    = starting_word
    @guesses = []
  end

  def word_guessed_so_far
    word.chars.map { |character| character if guesses.include?(character) }
  end

  def won?
    word == word_guessed_so_far.join
  end

  def lost?
    score == 0
  end

  def finished?
    won? || lost?
  end
end
