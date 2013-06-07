class CreateCardTable < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :front
      t.string :back
    end
  end
end
