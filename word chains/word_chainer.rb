require 'set'

class WordChainer
  attr_reader :dictionary, :all_seen_words
  attr_accessor :current_words

  def initialize(file_name)
    @dictionary = File.readlines(file_name).map(&:chomp)
    @dictionary = Set.new(@dictionary)
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}

    until current_words.empty? || all_seen_words.include?(target)
      explore_current_words
    end

    build_path(source, target)
  end

  def build_path(source, target)
    parent = all_seen_words[target]
    path = []
    until parent.nil?
      path.unshift(parent)
      parent = all_seen_words[parent]
    end
    path.unshift(source)
    path << target
    path
  end

  def explore_current_words
    new_current_words = []

    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adj|
        unless all_seen_words.include?(adj)
          new_current_words << adj
          all_seen_words[adj] = current_word
        end
      end
    end

    @current_words = new_current_words
  end

  def adjacent_words(word)
    letters = word.downcase.split("")
    adj_words = []

    letters.each_index do |idx|
      ("a".."z").each do |char|
        new_word_array = letters.dup
        new_word_array[idx] = char
        new_word = new_word_array.join("")
        adj_words << new_word if dictionary.include?(new_word) && new_word != word
      end
    end

    adj_words
  end

end

if __FILE__ == $PROGRAM_NAME
  test = WordChainer.new("dictionary.txt")
  p test.run("duck", "ruby")
end
