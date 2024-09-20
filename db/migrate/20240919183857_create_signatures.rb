class CreateSignatures < ActiveRecord::Migration[7.1]
  def change
    create_table :signatures do |t|
      t.integer :status, default: 0
      t.datetime :signed_at

      t.timestamps
    end
  end
end
