class CreateEvaluations < ActiveRecord::Migration[7.1]
  def change
    create_table :evaluations do |t|
      t.datetime :date
      t.text :comment
      t.decimal :total_score

      t.timestamps
    end
  end
end
