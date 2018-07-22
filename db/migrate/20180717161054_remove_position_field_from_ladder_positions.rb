class RemovePositionFieldFromLadderPositions < ActiveRecord::Migration[5.2]
  def change
    remove_column :ladder_positions, :position, :integer
  end
end
