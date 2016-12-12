class CardController < ApplicationController
  
  def show
    @card = Card.where(id: params[:id]).first
    respond_to { |format| format.json { render json: @card , status: :ok } }
  end
  
  def search    
    card_name = params[:card_name]    
    cards = Card.search_by_name(card_name).to_a
        
    if not cards.empty?
      render text: cards.to_json
    else
      render text: ""
    end
  end
end
