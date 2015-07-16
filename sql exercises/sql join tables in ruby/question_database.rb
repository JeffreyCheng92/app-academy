require 'singleton'
require 'sqlite3'
require 'byebug'
require_relative 'question_follows'
require_relative 'users'
require_relative 'questions'
require_relative 'question_like'
require_relative 'reply'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end

end


if __FILE__ == $PROGRAM_NAME

end
