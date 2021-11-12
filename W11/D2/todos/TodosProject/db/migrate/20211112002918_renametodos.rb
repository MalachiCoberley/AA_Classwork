class Renametodos < ActiveRecord::Migration[5.2]
  def change
    rename_table :todo, :todos
  end
end
