class AddDeckidToCards < ActiveRecord::Migration
  def change
    change_table(:cards) do |t|
      t.references :deck
    end
  end
end
