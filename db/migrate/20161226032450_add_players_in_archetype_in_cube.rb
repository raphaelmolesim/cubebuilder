class AddPlayersInArchetypeInCube < ActiveRecord::Migration[5.0]
  def change
    add_column :archetypes_in_cubes, :cube_players, :integer, default: nil
  end
end
