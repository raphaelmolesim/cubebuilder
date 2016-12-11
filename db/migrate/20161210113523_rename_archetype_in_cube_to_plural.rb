class RenameArchetypeInCubeToPlural < ActiveRecord::Migration[5.0]
  def change
    rename_table :archetypes_in_cube, :archetypes_in_cubes
  end
end
