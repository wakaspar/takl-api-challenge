# spec/models/address_spec.rb
require 'rails_helper'

# Test suite for the Item model
RSpec.describe Address, type: :model do
  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:route) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
end
