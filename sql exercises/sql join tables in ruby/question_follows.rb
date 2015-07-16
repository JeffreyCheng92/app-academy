class QuestionFollows

  def self.followers_for_question_id(q_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, q_id)
      SELECT
        users.*
      FROM
        question_follows
      JOIN
        users ON question_follows.follower_id = users.id
      WHERE
        question_follows.question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def self.followed_questions_for_user_id(u_id)

    results = QuestionsDatabase.instance.execute(<<-SQL, u_id)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.follower_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end
end
