class CardsShouldBelongsToArchetypes < ActiveRecord::Migration[5.0]
  def change
    
    create_table :archetypes_cards do |t|
      t.belongs_to :card, index: true
      t.belongs_to :archetype, index: true

      t.timestamps  
    end
    
  end
end
