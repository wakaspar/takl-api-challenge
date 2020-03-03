class Address < ApplicationRecord

  belongs_to :route

  #validations
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

end
