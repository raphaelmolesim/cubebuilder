class Wishlist < ApplicationRecord
  belongs_to :cube
  belongs_to :card
end