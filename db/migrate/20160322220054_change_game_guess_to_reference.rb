class ChangeGameGuessToReference < ActiveRecord::Migration
  def up
    create_table :guesses do |t|
      t.column :guess, "char(1)"
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end

    Game.all.each do |game|
      game.guesses.each do |guess|
        Guess.new(game: game, guess: guess).save
      end
    end

    remove_column :games, :guesses
  end
end
