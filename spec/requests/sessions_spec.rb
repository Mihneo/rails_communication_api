require 'rails_helper'

RSpec.describe 'Session', type: :request do
  let(:existing_user) { FactoryBot.attributes_for(:user) }
  let(:new_user) { FactoryBot.attributes_for(:user, username: 'New user') }

  describe 'create' do
    context 'when new user' do
      it 'should create the user' do
        post sessions_path(session: new_user)
        expect(response).to be_successful
        expect(response.body).to include('New user')
      end
    end

    context 'when existing user' do
      it 'should log in the user' do
        existing_user
        post sessions_path(session: existing_user)
        expect(response).to be_successful
      end
    end
  end
end