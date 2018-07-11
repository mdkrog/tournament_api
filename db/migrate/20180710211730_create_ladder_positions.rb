class CreateLadderPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :ladder_positions do |t|
      t.integer :position, default: 0
      t.integer :points, default: 0
      t.belongs_to :group, index: true
      t.belongs_to :participant, index: true

      t.timestamps
    end
  end
end
