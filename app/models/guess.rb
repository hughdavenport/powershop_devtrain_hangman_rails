class Guess < ActiveRecord::Base
  belongs_to :game
  validates :guess, uniqueness: { scope: :game }
  validates :guess, length: { is: 1 }
  validates :guess, format: { with: /\A[a-z]\z/ }
end
