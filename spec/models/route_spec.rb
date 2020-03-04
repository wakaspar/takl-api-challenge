# spec/models/route_spec.rb
require 'rails_helper'

# Test suite for the Todo model
RSpec.describe Route, type: :model do
  # Association test ~ ensure Route has a 1:m relationship to Address
  it { should have_many(:addresses).dependent(:destroy) }
  # Validation tests ~ ensure provider and geo_coordinates are present
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:geo_coordinates) }
  it { should validate_presence_of(:addresses) }
end
