class CreateGame
  attr_accessor :game

  def initialize(starting_lives)
    @starting_lives = starting_lives
  end

  def call
    self.game = Game.create(starting_lives: starting_lives)
    game if game.save
  end

  private

  attr_reader :starting_lives
end
