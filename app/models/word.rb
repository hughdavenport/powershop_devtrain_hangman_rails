class Word < ActiveRecord::Base
  belongs_to :WordList
  validates :word, length: { within: 4..10 }
  validates :word, format: { with: /\A[a-z]+\z/, message: "Only allows lower case letters" }
end
