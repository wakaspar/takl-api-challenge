class Address < ApplicationRecord
  # each Address belongs to one Route instance
  belongs_to :route

  # model validations
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
