class SubmitGuess
  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    @guess = @game.guesses.create(guess: @letter)
    @guess.save
  end

  def errors
    @guess.errors
  end
end
