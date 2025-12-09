class CreateQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :questions do |t|
      t.references :kanji, null: false, foreign_key: true
      t.text :content
      t.json :answer
      t.string :type
      t.string :level
      t.string :status

      t.timestamps
    end
  end
end
