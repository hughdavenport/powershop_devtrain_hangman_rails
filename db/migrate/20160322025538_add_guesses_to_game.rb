class AddGuessesToGame < ActiveRecord::Migration
  def change
    add_column :games, :guesses, :string
  end
end
