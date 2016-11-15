class RenemaFieldToughness < ActiveRecord::Migration[5.0]
  def change
    rename_column :cards, :toughtness, :toughness
  end
end
