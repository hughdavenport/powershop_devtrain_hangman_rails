class CreateGame
  def initialize(starting_lives)
    @starting_lives = starting_lives
  end

  def call
    self.game = Game.create(starting_lives: starting_lives)
    game if game.save
  end

  def errors
    game.errors
  end

  private

  attr_accessor :game
  attr_reader :starting_lives
end
