require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    
    let(:valid_credentials) do
      { email: user.email, name: user.name }.to_json
    end
    let(:invalid_credentials) do
      { email: 'not_whitelisted@example.com', name: 'Fred' }.to_json
    end

    context 'successfully sends email' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'status 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'invalid email address' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'returns error' do
        expect(json['message']).to match(/Invalid email/)
      end
    end
  end
end