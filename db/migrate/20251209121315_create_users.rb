class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :role
      t.integer :level
      t.integer :exp
      t.boolean :active

      t.timestamps
    end
  end
end
