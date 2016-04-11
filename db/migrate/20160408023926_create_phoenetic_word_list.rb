class CreatePhoeneticWordList < ActiveRecord::Migration
  PHOENETIC = [
    "alpha",
    "bravo",
    "charlie",
    "delta",
    "echo",
    "foxtrot",
    "golf",
    "hotel",
    "india",
    "juliet",
    "kilo",
    "lima",
    "mike",
    "november",
    "oscar",
    "papa",
    "quebec",
    "romeo",
    "sierra",
    "tango",
    "uniform",
    "violet",
    "whiskey",
    "xray",
    "yankee",
    "zulu",
  ]

  def change
    WordList.transaction do
      wordlist = WordList.create(name: "phoenetic")
      PHOENETIC.each { |word| wordlist.words.create(word: word) }
      wordlist.save
    end
  end
end
