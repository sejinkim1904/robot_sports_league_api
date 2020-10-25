class CreateRosters < ActiveRecord::Migration[6.0]
  def change
    create_table :rosters do |t|
      t.references :bot, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :total_stats
      t.integer :role, default: 0
    end
  end
end
