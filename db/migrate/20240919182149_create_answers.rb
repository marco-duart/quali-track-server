class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.decimal :score
      t.text :comment

      t.timestamps
    end
  end
end
