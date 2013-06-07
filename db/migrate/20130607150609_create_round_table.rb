class CreateRoundTable < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer  :num_correct
      t.integer  :num_incorrect
      t.references :deck
    end
  end
end
