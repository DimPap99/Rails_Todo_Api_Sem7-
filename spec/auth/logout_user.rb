require 'rails_helper'

Rspec.describe LogoutUser do
    let(:user) { invalidate(:user) }

    subject(:valid_auth_obj) {described_class.new(user.id)}

    subject(:invalid_auth_obj) {described_class.new(0)}

    describe '#call' do
        context 'when valid user_id' do
            it 'returns a token invalidation message' do
                message = valid_auth_obj.call
                expect(message).not_to be_nil
            end

        end

        context 'when invalid user_id' do
            it 'raises an authentication error' do
                expect {invalid_auth_obj.call}.to raise_error(ExceptionHandler::AuthenticationError, /invalid credentials/)
            end
        end

    end
end