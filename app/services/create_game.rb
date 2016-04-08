class CreateGame
  attr_reader :game, :word_list

  def initialize(starting_lives, wordlist_name = "default")
    @starting_lives = starting_lives
    @wordlist_name = wordlist_name
  end

  def call
    self.word_list = WordList.find_by(name: wordlist_name)
    return unless word_list
    self.game = Game.create(starting_lives: starting_lives, word: word_list.random_word)
    game if game.save
  end

  def errors
    game.errors if game
  end

  private

  attr_reader :starting_lives, :wordlist_name
  attr_writer :game, :word_list
end
