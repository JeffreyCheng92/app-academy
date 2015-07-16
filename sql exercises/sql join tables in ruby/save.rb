require 'active_support/inflector'

module Save

  def save
    ivars = self.instance_variables.map! { |el| el.to_s[1..-1] }
    params = ivars.map { |ivar| self.send(ivar) }

    table = self.class.to_s.downcase.pluralize
    id = params.shift

    num_args = ivars.length

    set_string = ivars.join(" = ?, ") + " = ?"

    if !id.nil?

      QuestionsDatabase.instance.execute(<<-SQL, *params, id: id)
        UPDATE
          #{table}
        SET
          #{set_string}
        WHERE
          id = :id
      SQL
    # else
    #   QuestionsDatabase.instance.execute(<<-SQL, *params)
    #     INSERT INTO
    #       users (fname, lname)
    #     VALUES
    #       (?, ?)
    #   SQL
    end

end
#   @id = QuestionsDatabase.instance.last_insert_row_id
#
# QuestionsDatabase.instance.execute(<<-SQL, *params, id: id)
#   UPDATE
#     users
#   SET
#     fname = ?, lname = ?
#   WHERE
#     id = :id
# SQL
#
# else
# QuestionsDatabase.instance.execute(<<-SQL, *params)
#   INSERT INTO
#     users (fname, lname)
#   VALUES
#     (?, ?)
# SQL
