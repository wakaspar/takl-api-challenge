# spec/requests/routes_spec.rb
require 'rails_helper'

RSpec.describe 'Routes API', type: :request do

    it "requests list of all routes" do
      route = Route.create(
      	{
          "provider": "de018897-1613-44a1-acc7-ccfb009249cb",
          "geo_coordinates": [34.98837, -85.1223],
          "addresses_attributes": [
            {
              "street_address": "676 Theron Ct",
              "city": "Pickerington",
              "state": "Ohio",
              "zip": "43147"
            },
            {
              "street_address": "1168 Stanyan St",
              "city": "San Francisco",
              "state": "California",
              "zip": "94117"
            },
            {
              "street_address": "59 N Lancaster St",
              "city": "Athens",
              "state": "Ohio",
              "zip": "45701"
            }
          ],
        }
      )
      get '/routes'
      expect(response).to be_successful
      expect(response.body).to include("provider")
    end

  #
  # # Test suite for POST /routes
  # describe 'POST /routes' do
  #   # valid payload
  #   let(:valid_attributes) { { provider: 'de018897-1613-44a1-acc7-ccfb009249cb', geo_coordinates: [34.98837, -85.1223] } }
  #
  #   context 'when the request is valid' do
  #     before { post '/routes', params: valid_hash_attributes }
  #
  #     it 'creates a route' do
  #       expect(json['provider']).to eq('de018897-1613-44a1-acc7-ccfb009249cb')
  #     end
  #
  #     it 'returns status code 201' do
  #       expect(response).to have_http_status(201)
  #     end
  #   end
  #
  #   context 'when the request is invalid' do
  #     before { post '/routes', params: { provider: '0e7c59c9-bbd2-4957-a388-0efbc1cc87f3', geo_coordinates: [39.3343442, -82.10511] } }
  #
  #     it 'returns status code 422' do
  #       expect(response).to have_http_status(422)
  #     end
  #
  #     it 'returns a validation failure message' do
  #       expect(response.body)
  #         .to match(/Validation failed: Created by can't be blank/)
  #     end
  #   end
  # end
  #
  # # Test suite for PUT /routes/:id
  # describe 'PUT /routes/:id' do
  #   let(:valid_attributes) { { provider: 'c805984b-842c-42f4-877b-ec9968883651', geo_coordinates: [37.76298, -122.45194] } }
  #
  #   context 'when the record exists' do
  #     before { put "/routes/#{route_id}", params: valid_attributes }
  #
  #     it 'updates the record' do
  #       expect(response.body).to be_empty
  #     end
  #
  #     it 'returns status code 204' do
  #       expect(response).to have_http_status(204)
  #     end
  #   end
  # end
  #
  # # Test suite for DELETE /routes/:id
  # describe 'DELETE /routes/:id' do
  #   before { delete "/routes/#{route_id}" }
  #
  #   it 'returns status code 204' do
  #     expect(response).to have_http_status(204)
  #   end
  # end

end
