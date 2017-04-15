#define RandomData as a module because it is a standalone library with no dependencies or inheritance requirements.

module RandomData


  def self.random_paragraph
    sentences = []
    #create 4 to 6 random_sentence and append them to sentences array
    rand(4..6).times do
      sentences << random_sentence
    end

    # combine sentences, passing a space to separate each sentence. combine them into a full paragraph (as a string)
    sentences.join(" ")
  end


  # create a sentence with 3 to 8 random_word
  def self.random_sentence
    strings = []

    rand(3..8).times do
      strings << random_word
    end

    # join the random_word in strings array to form a sentence.
    sentence = strings.join(" ")

    #convert first character to uppercase and the remainder of words to lowercase.
    sentence.capitalize << "."
  end


  def self.random_word
    # set 'letters' to array(to_a) of letters a-z
    letters = ('a'..'z').to_a
    letters.shuffle!

    # join the zeroth through nth(3 to 8) item in letters. results in a word that is 3-8 characters long
    letters[0,rand(3..8)].join
  end

  def self.random_boolean
    rand(0..1) == 1
  end
end
