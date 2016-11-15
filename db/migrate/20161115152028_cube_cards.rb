class CubeCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards_cubes do |t|
      t.belongs_to :card, index: true
      t.belongs_to :cube, index: true

      t.timestamps
    end
  end
end
