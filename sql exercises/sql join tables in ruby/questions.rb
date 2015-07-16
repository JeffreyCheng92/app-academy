class Question
  def self.find_by_author(a_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, a_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

  attr_accessor :id, :title, :body, :author_id

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    @author_id
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollows.followers_for_question_id(id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end

  def likers
    QuestionLike.likers_for_question_id(id)
  end

  def save
    params = [title, body, author_id]

    if id?
      QuestionsDatabase.instance.execute(<<-SQL, *params, id: id)
        UPDATE
          questions
        SET
          title = ?, body = ?, author_id = ?
        WHERE
          id = :id
      SQL

    else
      QuestionsDatabase.instance.execute(<<-SQL, *params)
        INSERT INTO
          questions (title, body, author_id)
        VALUES
          (?, ?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

end
