require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    through_options = assoc_options[through_name]

    define_method(name) do
      source_options = through_options.model_class.assoc_options[source_name]

      cat_foreign_key = through_options.foreign_key
      cat_f_key_id = self.send(cat_foreign_key)

      owner_p_key = through_options.primary_key

      owner_f_key = through_options.foreign_key
      owner_f_key_id = through_name.send(owner_f_key)

      house_p_key = source_options.primary_key

      query = DBConnection.execute(<<-SQL)
        SELECT
          #{source_options.model_class.table_name}.*
        FROM
          #{through_options.model_class.table_name} AS human
        JOIN
          #{source_options.model_class.table_name} AS house
        ON
          human.#{owner_f_key_id} = house.#{house_p_key}
        WHERE
          #{self.model_class.table_name}.#{cat_f_key_id} =
            human.#{owner_p_key}
      SQL

      query
    end

  end
end
