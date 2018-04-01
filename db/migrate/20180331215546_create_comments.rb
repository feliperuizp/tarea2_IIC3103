class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :author
      t.string :cbody
      t.integer :article_id

      t.timestamps
    end
  end
end
