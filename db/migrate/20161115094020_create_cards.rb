class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :manaCost
      t.integer :cmc
      t.string :text
      t.integer :power
      t.integer :toughtness
      

      t.timestamps
    end
    
    add_column :cards, :colors_list, :string
    add_column :cards, :types_list, :string
    add_column :cards, :subtype_list, :string
  end
end
