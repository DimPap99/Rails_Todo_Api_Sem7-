require 'rails_helper'

Rspec.describe LogoutUser do
    let(:token) { invalidate(:token) }

    subject(:valid_auth_obj) {described_class.new(token)}

    subject(:invalid_auth_obj) {described_class.new(nil)}

    describe '#call' do
        context 'when valid token' do
            it 'returns a token invalidation message' do
                message = valid_auth_obj.call
                expect(message).not_to be_nil
            end

        end

        context 'when invalid token' do
            it 'raises an authentication error' do
                message = /invalid credentials/
                expect {message}.to_be  /invalid credentials/
            end
        end

    end
end