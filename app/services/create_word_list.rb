class CreateWordList
  attr_reader :word_list

  def initialize(name, words)
    @name = name
    @words = words
  end

  def call
    self.word_list = WordList.create(name: name)
    words.each { |word| word_list.words.create(word: word) }
    word_list if word_list.save
  end

  private

  attr_reader :name, :words
  attr_writer :word_list
end
