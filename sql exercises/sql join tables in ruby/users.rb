class User
  def self.find_by_name(first, last)
    results = QuestionsDatabase.instance.execute(<<-SQL, first, last)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    results.map { |result| User.new(result) }
  end

  attr_accessor :id, :fname, :lname

  require 'save'

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollows.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    query = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      COUNT(ql.user_id) / CAST( COUNT(DISTINCT(q.id)) AS FLOAT) AS avg_karma
    FROM
      questions q
    LEFT OUTER JOIN
      question_likes ql ON q.id = ql.question_id
    WHERE
      q.author_id = :id
    SQL

    query
  end

  def save
    params = [fname, lname]

    if id?
      QuestionsDatabase.instance.execute(<<-SQL, *params, id: id)
        UPDATE
          users
        SET
          fname = ?, lname = ?
        WHERE
          id = :id
      SQL

    else
      QuestionsDatabase.instance.execute(<<-SQL, *params)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end


end
