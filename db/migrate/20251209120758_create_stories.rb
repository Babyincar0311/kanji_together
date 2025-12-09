class CreateStories < ActiveRecord::Migration[8.1]
  def change
    create_table :stories do |t|
      t.references :kanji, null: false, foreign_key: true
      t.text :content
      t.string :status
      t.boolean :ai_generated

      t.timestamps
    end
  end
end
