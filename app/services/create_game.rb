class CreateGame
  attr_reader :game

  def initialize(starting_lives)
    @starting_lives = starting_lives
  end

  def call
    @game = Game.create(starting_lives: @starting_lives)
    @game.save
  end

  def errors
    @game.errors
  end
end
