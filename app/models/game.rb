class Game < ActiveRecord::Base
  after_initialize :set_default_values
  has_many :guesses, dependent: :destroy

  DEFAULT_STARTING_LIVES = 10
  DEFAULT_STARTING_WORD  = "hangman"

  def set_default_values
    self.starting_lives ||= DEFAULT_STARTING_LIVES
    self.word           ||= DEFAULT_STARTING_WORD
  end

  def word_guessed_so_far
    word.chars.map { |character| character if guesses_array.include?(character) }
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

  # TODO, should we be overriding this?
  def guesses_array
    # Call the active record relation, and just get out the guess character, and join into an array
    guesses.all.map { |guess| guess.guess }
  end

  def correct_guesses
    guesses_array - incorrect_guesses
  end

  def incorrect_guesses
    guesses_array - word.chars
  end

  def submit_guess(guess)
    self.guesses.create(guess: guess)
  end
  # Required for rails to allow this as a form entry
  attr_accessor :guess
  alias_method :guess=, :submit_guess
end
