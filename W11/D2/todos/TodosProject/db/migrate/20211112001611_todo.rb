class Todo < ActiveRecord::Migration[5.2]
  def change
    create_table :todo do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.boolean :done
    end
  end
end
