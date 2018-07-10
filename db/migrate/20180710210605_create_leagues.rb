class CreateLeagues < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.integer :number_of_groups, default: 1
      t.belongs_to :tournament, index: true
      
      t.timestamps
    end
  end
end
