require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    query = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    query.first.keys.map(&:to_sym)
  end

  def self.finalize!
    variables = columns

    variables.each do |col|
      define_method("#{col}=") do |value|
        attributes[col] = value
      end

      define_method(col) do
        attributes[col]
      end
    end
  end

  def self.table_name=(table_name)
    instance_variable_set(:@table_name, table_name)
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    objects = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL

    parse_all(objects)
  end

  def self.parse_all(results)
    results.map { |object| self.new(object) }
  end

  def self.find(id)
    query = DBConnection.execute(<<-SQL, id)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        id = ?
      LIMIT
        1
    SQL

    parse_all(query).first
  end

  def initialize(params = {})
    params.each do |k, v|
      unless self.methods.include?("#{k}=".to_sym)
        raise "unknown attribute \'#{k}\'"
      end

      self.send "#{k}=".to_sym, v
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    table_columns = self.class.columns
    table_columns.map { |column| self.send column.intern }
  end

  def insert
    values = attribute_values
    table_columns = self.class.columns

    col_names = table_columns.join(", ")
    question_marks = (["?"] * table_columns.length).join(", ")
    DBConnection.execute(<<-SQL, *values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    values = attribute_values

    set_string = self.class.columns.map { |col| "#{col} = ?" }.join(", ")

    DBConnection.execute(<<-SQL, *values, self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_string}
      WHERE
        id = ?
    SQL
  end

  def save
    self.id.nil? ? insert : update
  end
end
