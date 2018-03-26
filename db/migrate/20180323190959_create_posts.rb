class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :post_id
      t.text :body
      t.timestamps 
    end
  end
end
