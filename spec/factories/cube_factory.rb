require "factory_girl"

FactoryGirl.define do
  
  factory :cube, class: Cube do |cube|
    cube.name "cube1"
  end

  factory :duress, class: Card do |card|
    card.name "Duress"
    card.id 341
  end
  
  factory :counterspell, class: Card do |card|
    card.name "Counterspell"
    card.id 326
  end
  
  factory :archetype, class: Archetype do |architype|
    architype.name "UB Control"
    architype.id 15
  end

  factory :selected_card, class: SelectedCard do |selected_card|
    association :cube, factory: :cube
    association :card, factory: :duress
    association :archetype, factory: :archetype
  end
end