module GamesHelper
  def guessed_word(game)
    game.word_guessed_so_far.map { |char| char ? char : " _ " }.join
  end

  def guessed_letters(game)
    game.guessed_letters.join(" ")
  end

  def wordlist_names
    WordList.pluck(:name)
  end
end
