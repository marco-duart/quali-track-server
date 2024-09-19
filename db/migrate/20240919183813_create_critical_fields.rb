class CreateCriticalFields < ActiveRecord::Migration[7.1]
  def change
    create_table :critical_fields do |t|
      t.string :title
      t.decimal :discount_percentage

      t.timestamps
    end
  end
end
