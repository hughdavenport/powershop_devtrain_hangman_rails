class AddWordToGame < ActiveRecord::Migration
  def change
    add_column :games, :word, :string
  end
end
