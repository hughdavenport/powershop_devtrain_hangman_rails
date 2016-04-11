module GamesHelper
  def guessed_word(game)
    game.word_guessed_so_far.map { |char| char ? char : " _ " }.join
  end
end
