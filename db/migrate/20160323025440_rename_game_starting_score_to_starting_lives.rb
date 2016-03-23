class RenameGameStartingScoreToStartingLives < ActiveRecord::Migration
  def change
    rename_column :games, :starting_score, :starting_lives
  end
end
