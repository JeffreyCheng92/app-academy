class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false

      t.integer :parent_comment_id

      t.text :content, null: false
      t.integer :author_id, null: false
      t.integer :post_id, null: false

      t.timestamps null: false
    end

    add_index :comments, :commentable_id
    add_index :comments, :parent_comment_id
    add_index :comments, :author_id
    add_index :comments, :post_id
  end
end
