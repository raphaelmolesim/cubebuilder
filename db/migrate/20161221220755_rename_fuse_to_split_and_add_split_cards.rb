class RenameFuseToSplitAndAddSplitCards < ActiveRecord::Migration[5.0]
  def change
    rename_column :cards, :fuse_id, :split_card_id
    
    fuses = File.readlines("#{Rails.root}/db/cards-with-fuse.txt")
    
    File.readlines("#{Rails.root}/db/cards-with-split.txt").each do |line|
      
      next if fuses.include? line
      
      # example: Death (Life/Death)
      array = line.split("(")
      card_name = array.first.strip
      split_card_name = (array.last.gsub(")", "").split("/") - [ card_name ]).first.strip
          
      
      card = Card.where(name: card_name).first
      split_card = Card.where(name: split_card_name).first
      puts "Spliting > #{card_name} with #{split_card_name}"
      card.split_card_id = split_card.id
      card.save!
      
    end
  end
end
