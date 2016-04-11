class Game < ActiveRecord::Base
  DEFAULT_STARTING_LIVES = 10
  DEFAULT_WORDLIST_NAME = "default"

  has_many :guesses, dependent: :destroy

  after_initialize :set_default_values

  validates :starting_lives, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :word, presence: true

  attr_reader :wordlist_name

  def set_default_values
    self.starting_lives ||= DEFAULT_STARTING_LIVES
    self.wordlist_name ||= DEFAULT_WORDLIST_NAME
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

  private

  attr_writer :wordlist_name
end
