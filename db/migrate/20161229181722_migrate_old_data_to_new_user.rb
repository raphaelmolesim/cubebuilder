class MigrateOldDataToNewUser < ActiveRecord::Migration[5.0]
  def up
    user = User.new({
      email: "raphael.sm86@gmail.com",
      password: "novasenha",
      password_confirmation: "novasenha"
    })
    user.save!
    
    Cube.all.each do |cube|
      cube.user = user
      puts " #{cube.name} => Saved: #{cube.save!}"
    end
    
    Archetype.all.each do |archetype|
      archetype.user = user
      puts " #{archetype.name} => Saved: #{archetype.save!}"
    end
    
  end
  
  def down
    User.where(email: "raphael.sm86@gmail.com").delete_all
  end
  
end
