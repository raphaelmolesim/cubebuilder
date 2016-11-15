class CardController < ApplicationController
  
  def search    
    card_name = params[:card_name]    
    @cards ||= JSON File.read("#{Rails.root}/db/all-cards.json")    
    card = @cards[card_name]    
    
    if card
      render text: card.to_json
    else
      render text: ""
    end
  end
  
end
