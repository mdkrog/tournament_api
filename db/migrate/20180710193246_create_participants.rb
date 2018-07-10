class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.string :name, null: false, index: true

      t.timestamps
    end
  end
end
