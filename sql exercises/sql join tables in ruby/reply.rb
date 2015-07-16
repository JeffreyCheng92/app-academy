class Reply

  def self.find_by_user_id(u_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, u_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  def self.find_by_question_id(q_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, q_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  attr_accessor :id, :body, :question_id, :user_id, :reply_id

  def initialize(options = {})
    @id = options['id']
    @body = options['body']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @reply_id = options['reply_id']
  end

  def author
    @user_id
  end

  def question
    @question_id
  end

  def parent_reply
    @reply_id
  end

  def child_replies
    query = <<-SQL
    SELECT
      *
    FROM
      replies
    WHERE
      replies.reply_id = #{@id}
    SQL

    QuestionsDatabase.instance.execute(query)
  end

  def save
    params = [body, question_id, user_id, reply_id]

    if id?
      QuestionsDatabase.instance.execute(<<-SQL, *params, id: id)
        UPDATE
          replies
        SET
          body = ?, question_id = ?, user_id = ?, reply_id = ?
        WHERE
          id = :id
      SQL

    else
      QuestionsDatabase.instance.execute(<<-SQL, *params)
        INSERT INTO
          replies (body, question_id, user_id, reply_id)
        VALUES
          (?, ?, ?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

end
