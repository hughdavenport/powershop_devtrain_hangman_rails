class Guess < ActiveRecord::Base
  belongs_to :game
  validates :guess, uniqueness: { scope: :game }
end
