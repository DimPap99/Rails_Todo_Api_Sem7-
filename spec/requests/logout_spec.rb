# spec/requests/authentication_spec.rb
require 'rails_helper'

RSpec.describe 'Logout' do
  # Authentication test suite
  describe 'POST /auth/logout' do
    # create test user
    let!(:user) { create(:user) }
    # set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }
    # set test valid and invalid credentials
    let(:valid_token) do
      {
        token: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
        
      }.to_json
    end
    let(:invalid_token) do
      {
        token: nil
      }.to_json
    end

    
    # returns auth token when request is valid
    context 'When request is valid' do
      before { post '/auth/logout', params: valid_token, headers: headers }
       
      it 'returns status code 200' do
        expect(json['message']).not_to be_nil
      end
    end

    # returns failure message when request is invalid
    context 'When request is invalid' do
      before { post '/auth/logout', params: invalid_token, headers: headers }

      it 'returns a failure message' do
        p json['message']
        expect(json['message']).to match("Missing token")
      end
    end
  end
end