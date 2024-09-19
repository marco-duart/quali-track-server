class AddRelations < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :team, foreign_key: true
    add_reference :teams, :manager, foreign_key: { to_table: :users }
    add_reference :evaluations, :employee, foreign_key: { to_table: :users }
    add_reference :evaluations, :monitor, foreign_key: { to_table: :users }
    add_reference :answers, :evaluation, foreign_key: true
    add_reference :answers, :question, foreign_key: true
    add_reference :critical_fields, :evaluation, foreign_key: true
    add_reference :signatures, :evaluation, foreign_key: true
    add_reference :signatures, :user, foreign_key: true
  end
end
