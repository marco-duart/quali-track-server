class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.decimal :score
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
