class AddDisciplineAndScoreFields < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :discipline, :integer, default: 0
    add_column :league_matches, :score, :json
    add_column :leagues, :league_settings, :json
    remove_column :league_matches, :winner, :integer
  end
end
