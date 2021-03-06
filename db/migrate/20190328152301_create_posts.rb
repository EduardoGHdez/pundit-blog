class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.boolean :published
      t.references :user, foreign_key: true
      t.text :content
      t.string :title

      t.timestamps
    end
  end
end
