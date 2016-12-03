class RenameArchetypes < ActiveRecord::Migration[5.0]
  def change
    rename_table :architypes, :archetypes
  end
end
