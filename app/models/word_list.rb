class WordList < ActiveRecord::Base
  has_many :words, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true

  def random_word
    words.sample[:word]
  end
end
