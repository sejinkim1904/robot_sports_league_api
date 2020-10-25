class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :email
      t.string :password_digest
      t.string :name

      t.timestamps
    end
  end
end
