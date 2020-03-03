class Route < ApplicationRecord
  # associations to addresses
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses

  # model validations
  validates :provider, presence: true
  validates :geo_coordinates, length: {maximum:2}, presence: true
  validates :addresses, presence: true
end
