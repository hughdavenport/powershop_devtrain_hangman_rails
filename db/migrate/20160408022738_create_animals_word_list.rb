class CreateAnimalsWordList < ActiveRecord::Migration
  ANIMALS = [
    "anteater",
    "bear",
    "chicken",
    "donkey",
    "elephant",
    "fantail",
    "giraffe",
    "hippopotomus",
    "iguana",
    "jackal",
    "koala",
    "llama",
    "monkey",
    "narwhal",
    "otter",
    "penguin",
    "quagga",
    "rabbit",
    "skink",
    "tadpole",
    "unicorn",
    "vulture",
    "whale",
    "xerus",
    "yabby",
    "zebra",
  ]

  def change
    WordList.transaction do
      wordlist = WordList.create(name: "animals")
      ANIMALS.each { |word| wordlist.words.create(word: word) }
      wordlist.save
    end
  end
end
