class WordList < ActiveRecord::Base
  has_many :words, dependent: :destroy
  validates :name, presence: true
end
