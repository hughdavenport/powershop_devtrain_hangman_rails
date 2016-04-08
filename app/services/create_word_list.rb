class CreateWordList
  attr_reader :word_list

  def initialize(name, words)
    @name = name
    @words = words
  end

  def call
    WordList.transaction do
      self.word_list = WordList.create(name: name)
      words.each { |word| word_list.words.create(word: word) }
      raise ActiveRecord::Rollback if word_list.words.count != words.count
      word_list if word_list.save
    end
  end

  def errors
    if word_list
      word_list.valid?
      errors = word_list.errors
      if errors.messages.include?(:words)
        errors.messages[:words] = []
        word_list.words.each_with_index do |word, index|
          errors.messages[:words][index] = word.errors.messages[:word] unless word.errors.empty?
        end
      end
      errors
    end
  end

  private

  attr_reader :name, :words
  attr_writer :word_list
end
