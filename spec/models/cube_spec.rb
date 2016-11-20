require 'rails_helper'

describe Cube, :type => :model do

  context "#sync_all_cube" do
    
    it "update cube with one card" do
      cube = create(:cube)
      card = create(:duress)
      architype = create(:architype)
      
      result = cube.sync_all_cube [ { "id": card.id, 
        "architypes": [ architype.id ] } ]
      
      expect(result).to be(true)
      expect(SelectedCard.all.size).to be(1) 
      
    end
    
    it "update cube with two different card" do
      cube = create(:cube)
      card1 = create(:duress)
      card2 = create(:counterspell)
      architype = create(:architype)
      
      result = cube.sync_all_cube [ { "id": card1.id, 
        "architypes": [ architype.id ] },{ "id": card2.id, 
        "architypes": [ architype.id ] } ]
      
      expect(result).to be(true)
      expect(SelectedCard.all.size).to be(2) 
      
    end
    
    it "update cube with one card that alreay exists" do
      selected_card = create(:selected_card)
      cube = selected_card.cube
      
      result = cube.sync_all_cube [ { "id": selected_card.card_id, 
        "architypes": [ selected_card.architype_id ] } ]
      
      expect(result).to be(true)
      expect(SelectedCard.all.size).to be(1) 
      
    end
    
    it "update cube with one card with two architypes" do
      cube = create(:cube)
      card1 = create(:duress)
      architype1 = create(:architype)
      architype2 = create(:architype, name: "BW Aggro", id: 14)
      
      result = cube.sync_all_cube [ { "id": card1.id, 
        "architypes": [ architype1.id, architype2.id ] } ]
      
      expect(result).to be(true)
      expect(SelectedCard.all.size).to be(2)
    end
    
    it "update cube with one card that already exists and add a new architype" do
      selected_card = create(:selected_card)
      cube = selected_card.cube
      architype2 = create(:architype, name: "BW Aggro", id: 14)
      
      result = cube.sync_all_cube [ { "id": selected_card.card_id, 
        "architypes": [ selected_card.architype_id, architype2.id ] } ]
      
      expect(result).to be(true)
      expect(SelectedCard.all.size).to be(2)
    end
    
    it "update cube with one card that already exists and reset it" do
      selected_card = create(:selected_card)
      cube = selected_card.cube
      
      result = cube.sync_all_cube [  ]
      
      expect(result).to be(true)
      expect(SelectedCard.all.size).to be(0)
    end
        
  end


end