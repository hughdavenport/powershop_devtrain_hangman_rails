class Game < ActiveRecord::Base
  after_initialize :set_default_values
  has_many :guesses

  DEFAULT_STARTING_SCORE = 10
  DEFAULT_STARTING_WORD  = "hangman"

  def set_default_values
    self.starting_score ||= DEFAULT_STARTING_SCORE
    self.word           ||= DEFAULT_STARTING_WORD
    self.guesses        ||= []
  end

  def word_guessed_so_far
    word.chars.map { |character| character if guesses.include?(character) }
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
    self.starting_score - incorrect_guesses.length
  end

  def guesses
    # Call the active record relation, and just get out the guess character, and join into an array
    super.all.map { |guess| guess.guess }
  end

  def correct_guesses
    guesses - incorrect_guesses
  end

  def incorrect_guesses
    guesses - word.chars
  end

  def submit_guess(guess)
    g = Guess.new(game: self, guess: guess);g.save
  end
end
