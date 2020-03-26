require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  subject(:valid_auth_obj) { described_class.new(user.email, user.name) }
  subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

  describe '#call' do
    context 'whitelisted email' do
      it 'returns auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    context 'non whitelisted email' do
      it 'AuthenticationError' do
        expect { invalid_auth_obj.call }
          .to raise_error(ExceptionHandler::AuthenticationError, /Invalid email/)
      end
    end
  end

end