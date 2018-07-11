class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.belongs_to :league, index: true

      t.timestamps
    end
  end
end
