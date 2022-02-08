require 'rails_helper'

RSpec.describe 'Message', type: :request do
  let(:existing_user) { FactoryBot.attributes_for(:user) }
  let(:message) { FactoryBot.attributes_for(:message, receiver_ids: [User.first.id]) }
  let(:bad_message) { FactoryBot.attributes_for(:message) }

  describe 'create' do
    context 'when user logged in' do
      before(:each) do
        post sessions_path(session: existing_user)
      end

      context 'when existing user' do
        before(:each) { post messages_path(message: message) }

        it 'should be successful' do
          expect(response).to be_successful
        end

        it 'should create the new message' do
          expect(response.body).to include('All messages sent successfully!')
        end
      end

      context 'when not existing user' do
        before(:each) { post messages_path(message: bad_message) }

        it 'should return error message' do
          expect(response).to_not be_successful
        end

        it 'should return bad request' do
          expect(response.status).to eq(400)
        end
      end
    end

    context 'when user not logged in' do
      before(:each) { post messages_path(message: bad_message) }

      it 'should not be successful' do
        expect(response).to_not be_successful
      end

      it 'should be unauthorized' do
        expect(response.status).to eq(401)
      end
    end
  end
end
