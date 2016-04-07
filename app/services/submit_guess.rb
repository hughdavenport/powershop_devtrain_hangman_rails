class SubmitGuess
  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    self.guess = game.guesses.create(guess: letter)
    guess.save
  end

  def errors
    guess.errors
  end

  private

  attr_reader :game, :letter
  attr_accessor :guess
end
