class Route < ApplicationRecord

  # association to addresses
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses

  #validations
  #TODO

end
