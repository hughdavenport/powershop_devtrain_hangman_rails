class Word < ActiveRecord::Base
  DEFAULT_PAGINATION_LENGTH = 50

  belongs_to :WordList
  validates :word, length: { within: 4..10 }
  validates :word, format: { with: /\A[a-z]+\z/, message: "Only allows lower case letters" }

  scope :paginate, ->(start = 0, length = DEFAULT_PAGINATION_LENGTH) { offset(start).limit(length) }
  scope :page, ->(num = 1) { paginate((num - 1) * DEFAULT_PAGINATION_LENGTH) }

  def self.default_pagination_length
    DEFAULT_PAGINATION_LENGTH
  end
end
