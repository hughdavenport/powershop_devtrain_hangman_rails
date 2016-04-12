class Guess < ActiveRecord::Base
  belongs_to :game
  validates :guess, uniqueness: { scope: :game }
  validates :guess, length: { is: 1 }
  validates :guess, format: { with: /\A[a-z]\z/ }
  validate :game_running

  def game_running
    errors.add(:game, errors.generate_message(:game, :is_finished)) if game.finished?
  end
end
