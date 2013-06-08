class AddUseridToRound < ActiveRecord::Migration
  def change
    change_table(:rounds) do |t|
      t.references :user
    end
  end
end
