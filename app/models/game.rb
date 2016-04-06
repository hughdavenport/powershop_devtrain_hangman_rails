class Game < ActiveRecord::Base
  DEFAULT_STARTING_LIVES = 10
  DEFAULT_STARTING_WORD  = "hangman"

  has_many :guesses, dependent: :destroy

  after_initialize :set_default_values

  def set_default_values
    self.starting_lives ||= DEFAULT_STARTING_LIVES
    self.word           ||= DEFAULT_STARTING_WORD
  end

  def word_guessed_so_far
    word.chars.map { |character| character if guessed_letters.include?(character) }
  end

  def won?
    word == word_guessed_so_far.join
  end

  def lost?
    lives == 0
  end

  def finished?
    won? || lost?
  end

  def lives
    self.starting_lives - incorrect_guesses.length
  end

  def guessed_letters
    guesses.pluck(:guess)
  end

  def correct_guesses
    guessed_letters - incorrect_guesses
  end

  def incorrect_guesses
    guessed_letters - word.chars
  end
end
