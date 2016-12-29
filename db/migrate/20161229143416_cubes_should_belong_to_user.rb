class CubesShouldBelongToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :cubes, :user, index:true
  end
end
