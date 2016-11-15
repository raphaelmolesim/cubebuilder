class CreateCubes < ActiveRecord::Migration[5.0]
  def change
    create_table :cubes do |t|
      t.string :name
      t.string :password

      t.timestamps
    end
  end
end
