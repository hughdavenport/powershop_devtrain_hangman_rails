class CreateGame
  attr_reader :game, :word_list

  def initialize(starting_lives:, wordlist_name:)
    @starting_lives = starting_lives
    @wordlist_name = wordlist_name
  end

  def call
    self.word_list = WordList.find_by(name: wordlist_name)
    if !word_list
      self.game = Game.create(starting_lives: starting_lives)
    else
      self.game = Game.create(starting_lives: starting_lives, word: word_list.random_word)
    end
    game if game.save
  end

  def errors
    game.errors.tap do |errors|
      if errors.messages.include?(:word)
        errors.messages[:wordlist_name] = [errors.generate_message(:wordlist_name)]
        errors.messages.delete(:word)
      end
    end
  end

  private

  attr_reader :starting_lives, :wordlist_name
  attr_writer :game, :word_list
end
