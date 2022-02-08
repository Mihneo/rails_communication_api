require 'rails_helper'

RSpec.describe 'Session', type: :request do
  let(:existing_user) { FactoryBot.attributes_for(:user) }
  let(:new_user) { FactoryBot.attributes_for(:user, username: 'New user') }

  describe 'create' do
    context 'when new user' do
      before(:each) { post sessions_path(session: new_user) }

      it 'should be successful' do
        expect(response).to be_successful
      end

      it 'should create the new user' do
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