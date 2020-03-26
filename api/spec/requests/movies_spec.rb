require 'rails_helper'

RSpec.describe 'Movies API', type: :request do
  let(:user) { create(:user) }
  let!(:movies) { create_list(:movie, 10) }
  let(:movie_id) { movies.first.id }

  let(:headers) { valid_headers }

  describe 'GET /movies' do
    before { get '/movies', params: {}, headers: headers }

    it 'returns movies' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
  end

  describe 'GET /movies/:id' do
    before { get "/movies/#{movie_id}", params: {}, headers: headers }

    context 'movie exists' do
      it 'returns the movie' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(movie_id)
      end

      it 'status 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'movie does not exist' do
      let(:movie_id) { 100 }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Movie/)
      end
    end
  end

  describe 'POST /movies' do
    let(:valid_attributes) do
      { title: 'Shrek', tmdb_id: 808, tags: [] }.to_json
    end

    context 'valid request' do
      before { post '/movies', params: valid_attributes, headers: headers }

      it 'creates movie' do
        expect(json['title']).to eq('Shrek')
      end

      it 'returns status 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'invalid request' do
      before { post '/movies', params: { title: 'Shrek' }.to_json, headers: headers }

      it 'returns status 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(response.body).to match(/param is missing or the value is empty: tmdb_id/)
      end
    end
  end

  describe 'PUT /movies/:id' do
    let(:valid_attributes) do
      { title: 'Toy Story', tmdb_id: 862, tags: [] }.to_json
    end

    context 'movie exists' do
      before { put "/movies/#{movie_id}", params: valid_attributes, headers: headers }

      it 'updates movie' do
        expect(response.body).to be_empty
      end

      it 'returns status 204' do
        expect(response).to have_http_status(204)
      end
    end

    # TODO: Test if movie does not exist
  end

  describe 'DELETE /movies/:id' do
    before { delete "/movies/#{movie_id}", params: {}, headers: headers }

    it 'returns status 204' do
      expect(response).to have_http_status(204)
    end
  end

  describe 'GET /movies/dropdown' do
    # TODO: Should mock this
    before { get '/movies/dropdown', params: { title: 'Shrek' }, headers: headers }

    it 'returns json' do
      expect(json).not_to be_empty
    end

    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end
  end

end