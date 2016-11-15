namespace :cards do
  
=begin

{
		"layout": "normal",
		"name": "Air Elemental",
		"manaCost": "{3}{U}{U}",
		"cmc": 5,
		"colors": ["Blue"],
		"type": "Creature — Elemental",
		"types": ["Creature"],
		"subtypes": ["Elemental"],
		"text": "Flying",
		"power": "4",
		"toughness": "4",
		"imageName": "air elemental",
		"colorIdentity": ["U"]
}

=end
  
  desc "Create cards based on db/all-cards.json"
  task create: :environment do
    if Card.all.size > 0 
      puts "Cards data already existent, try to use cards:sync"
    else
      cards = JSON File.read("#{Rails.root}/db/all-cards.json")    
      cards.each do |name, item|
        c = Card.new
        c.name = item["name"]
        c.manaCost = item["manaCost"]
        c.cmc = item["cmc"]
        c.colors = item["colors"]
        c.types = item["types"]
        c.subtypes = item["subtypes"]
        c.text = item["text"]
        c.power = item["power"]
        c.toughness = item["toughness"]
        c.save!
        print "."
      end
    end
  end

  desc "Syncronize database with all-cards.json"
  task sync: :environment do
    cards = JSON File.read("#{Rails.root}/db/all-cards.json")    
    cards.each do |name, item|
      c = Card.where(name: name).first
      if c
        c.manaCost = item["manaCost"]
        c.cmc = item["cmc"]
        c.colors = item["colors"]
        c.types = item["types"]
        c.subtypes = item["subtypes"]
        c.text = item["text"]
        c.power = item["power"]
        c.toughness = item["toughness"]
        c.save!
      else
        c = Card.new
        c.name = item["name"]
        c.manaCost = item["manaCost"]
        c.cmc = item["cmc"]
        c.colors = item["colors"]
        c.types = item["types"]
        c.subtypes = item["subtypes"]
        c.text = item["text"]
        c.power = item["power"]
        c.toughness = item["toughness"]
        c.save!
        print "."
      end
    end
  end

end
