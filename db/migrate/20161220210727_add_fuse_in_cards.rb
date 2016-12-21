class AddFuseInCards < ActiveRecord::Migration[5.0]
  def change    
    add_column :cards, :fuse_id, :integer, default: nil
    
    File.readlines("#{Rails.root}/db/cards-with-fuse.txt").each do |line|
      
      # example: Blood (Flesh/Blood)
      array = line.split("(")
      card_name = array.first.strip
      fuse_card_name = (array.last.gsub(")", "").split("/") - [ card_name ]).first.strip
          
      card = Card.where(name: card_name).first
      fuse_card = Card.where(name: fuse_card_name).first
      puts "Fusing > #{card_name} with #{fuse_card_name}"
      card.fuse_id = fuse_card.id
      card.save!
      
    end    
    
  end
end
