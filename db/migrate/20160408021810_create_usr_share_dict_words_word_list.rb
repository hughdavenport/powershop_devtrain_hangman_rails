class CreateUsrShareDictWordsWordList < ActiveRecord::Migration
  def up
    WordList.transaction do
      wordlist = WordList.create(name: "default")
      File.readlines("/usr/share/dict/words")
          .map { |line| line.chomp }
          .select { |line| line =~ /^[a-z]{3,10}$/ }
          .each { |word| wordlist.words.create(word: word) }
      wordlist.save
    end
  end
end
