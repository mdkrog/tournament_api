class CreateTournamentParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :tournament_participants do |t|
      t.integer :seeding, default: 0
      t.belongs_to :tournament, index: true
      t.belongs_to :participant, index: true

      t.timestamps
    end
  end
end
