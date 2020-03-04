# # spec/requests/addresses_spec.rb
# require 'rails_helper'
#
# RSpec.describe 'Addresses API' do
#   # Initialize the test data
#   let!(:route) { create(:route) }
#   let!(:addresses) { create_list(:address, 20, route_id: route.id) }
#   let(:route_id) { route.id }
#   let(:id) { addresses.first.id }
#
#   # Test suite for GET /routes/:route_id/addresses
#   describe 'GET /routes/:route_id/addresses' do
#     before { get "/routes/#{route_id}/addresses" }
#
#     context 'when route exists' do
#       it 'returns status code 200' do
#         expect(response).to have_http_status(200)
#       end
#
#       it 'returns all route addresses' do
#         expect(json.size).to eq(20)
#       end
#     end
#
#     context 'when route does not exist' do
#       let(:route_id) { 0 }
#
#       it 'returns status code 404' do
#         expect(response).to have_http_status(404)
#       end
#
#       it 'returns a not found message' do
#         expect(response.body).to match(/Couldn't find route/)
#       end
#     end
#   end
#
#   # Test suite for GET /routes/:route_id/addresses/:id
#   describe 'GET /routes/:route_id/addresses/:id' do
#     before { get "/routes/#{route_id}/addresses/#{id}" }
#
#     context 'when route address exists' do
#       it 'returns status code 200' do
#         expect(response).to have_http_status(200)
#       end
#
#       it 'returns the address' do
#         expect(json['id']).to eq(id)
#       end
#     end
#
#     context 'when route address does not exist' do
#       let(:id) { 0 }
#
#       it 'returns status code 404' do
#         expect(response).to have_http_status(404)
#       end
#
#       it 'returns a not found message' do
#         expect(response.body).to match(/Couldn't find address/)
#       end
#     end
#   end
#
#   # Test suite for PUT /routes/:route_id/addresses
#   describe 'POST /routes/:route_id/addresses' do
#     let(:valid_attributes) { { street_address: '59 N. Lancaster', city: 'Athens', state: 'OH', zip: '45701' } }
#
#     context 'when request attributes are valid' do
#       before { post "/routes/#{route_id}/addresses", params: valid_attributes }
#
#       it 'returns status code 201' do
#         expect(response).to have_http_status(201)
#       end
#     end
#
#     context 'when an invalid request' do
#       before { post "/routes/#{route_id}/addresses", params: {} }
#
#       it 'returns status code 422' do
#         expect(response).to have_http_status(422)
#       end
#
#       it 'returns a failure message' do
#         expect(response.body).to match(/Validation failed: Name can't be blank/)
#       end
#     end
#   end
#
#   # Test suite for PUT /routes/:route_id/addresses/:id
#   describe 'PUT /routes/:route_id/addresses/:id' do
#     let(:valid_attributes) { { street_address: '59 N. Lancaster', city: 'Athens', state: 'OH', zip: '45701' } }
#
#     before { put "/routes/#{route_id}/addresses/#{id}", params: valid_attributes }
#
#     context 'when address exists' do
#       it 'returns status code 204' do
#         expect(response).to have_http_status(204)
#       end
#
#       it 'updates the address' do
#         updated_address = address.find(id)
#         expect(updated_address.street_address).to match(/59 N. Lancaster Athens, OH 45701/)
#       end
#     end
#
#     context 'when the address does not exist' do
#       let(:id) { 0 }
#
#       it 'returns status code 404' do
#         expect(response).to have_http_status(404)
#       end
#
#       it 'returns a not found message' do
#         expect(response.body).to match(/Couldn't find address/)
#       end
#     end
#   end
#
#   # Test suite for DELETE /routes/:id
#   describe 'DELETE /routes/:id' do
#     before { delete "/routes/#{route_id}/addresses/#{id}" }
#
#     it 'returns status code 204' do
#       expect(response).to have_http_status(204)
#     end
#   end
# end
