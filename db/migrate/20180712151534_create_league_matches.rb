class CreateLeagueMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :league_matches do |t|
      t.integer :winner
      t.integer :round
      t.belongs_to :group, index: true
      t.references :participant1, index: true
      t.references :participant2, index: true
      t.timestamps
    end

    add_foreign_key :matches, :participants, column: :participant1_id, primary_key: :id
    add_foreign_key :matches, :participants, column: :participant2_id, primary_key: :id
  end
end
