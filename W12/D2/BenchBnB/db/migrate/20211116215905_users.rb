class Users < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null:false
      t.string :password_digest
      t.string :session_token
    end
  end
end
