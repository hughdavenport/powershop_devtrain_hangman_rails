class AddStartingScoreToGame < ActiveRecord::Migration
  def change
    add_column :games, :starting_score, :integer
  end
end
