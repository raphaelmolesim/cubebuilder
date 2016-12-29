class ArchetypesShouldBelongsToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :archetypes, :user, index:true
  end
end
