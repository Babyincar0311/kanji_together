class CreateKanjis < ActiveRecord::Migration[8.1]
  def change
    create_table :kanjis do |t|
      t.string :character
      t.string :hanviet
      t.string :meaning
      t.string :onyomi
      t.string :kunyomi
      t.string :level
      t.integer :strokes
      t.string :radical

      t.timestamps
    end
  end
end
