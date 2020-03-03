class Route < ApplicationRecord

  # serialize geo coordinates into an Array
  serialize :geo_coordinates, Array

  # association to addresses
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses


  #validations
  #TODO

end
