class QuestionLike

  def self.likers_for_question_id(q_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, q_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?
      SQL

    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(q_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, q_id)
      SELECT
        COUNT(users.id)
      FROM
        question_likes
      JOIN
        users ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?
      SQL

    results
  end

  def self.liked_questions_for_user_id(u_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, u_id)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = ?
      SQL

    results.map { |result| Question.new(result) }
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON questions.id = question_likes.question_id
      GROUP BY
        question_likes.question_id
      HAVING
        COUNT(question_likes.user_id) >= ?
      SQL

    results.map { |result| Question.new(result) }
  end

  def self.most_liked(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON questions.id = question_likes.question_id
      GROUP BY
        question_likes.question_id
      ORDER BY
        COUNT(question_likes.user_id) DESC
      LIMIT
        ?
      SQL

    results.map { |result| Question.new(result) }
  end

end
