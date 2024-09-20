class CreateEvaluationCriticalFields < ActiveRecord::Migration[7.1]
  def change
    create_table :evaluation_critical_fields do |t|
      t.references :evaluation, null: false, foreign_key: true
      t.references :critical_field, null: false, foreign_key: true

      t.timestamps
    end
  end
end
