require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }
  let(:header) {
    { 'Authorization' => token_generator(user.id) }
  }

  subject(:invalid_request_obj) { described_class.new({}) }
  subject(:valid_request_obj) { described_class.new(header) }

  describe '#call' do
    context 'valid request' do
      it 'returns user' do
        result = valid_request_obj.call
        expect(result[:user]).to eq(user)
      end
    end

    context 'invalid request' do
      context 'missing token' do
        it 'raises MissingToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'invalid token' do
        subject(:invalid_request_obj) do
          described_class.new('Authorization' => token_generator(5))
        end

        it 'raises InvalidToken error' do
          expect { invalid_request_obj.call }
           .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      context 'Expired token' do
        let(:header) {
          { 'Authorization' => expired_token_generator(user.id) }
        }

        # TODO: This should return a different error
        it 'raises ExpiredToken error' do
          expect { valid_request_obj.call }
            .to raise_error(ExceptionHandler::ExpiredToken, /Expired token/)
        end
      end

      context 'Fake token' do
        let(:header) {
          { 'Authorization' => 'foobar' }
        }
        subject(:invalid_request_obj) { described_class.new(header) }

        it 'Handles JWT::DecodeError' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end
    end
  end
end
