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

  describe 'index' do
    before(:each) do
      post sessions_path(session: existing_user)
      post messages_path(message: message)
    end

    context 'when wants to read all messages' do
      before(:each) { get messages_path }

      it 'should be successful' do
        expect(response).to be_successful
      end

      it 'should contain the message' do
        expect(response.body).to include(message[:body])
      end
    end

    context 'when wants to read new messages' do
      before(:each) { get messages_path(unseen: 'true') }

      context 'when having unseen messages' do
        it 'should be successful' do
          expect(response).to be_successful
        end

        it 'should contain the message' do
          expect(response.body).to include(message[:body])
        end
      end

      context 'when not having unseen messages' do
        before(:each) { get messages_path(unseen: 'true') }

        it 'should be successful' do
          expect(response).to be_successful
        end

        it 'should be empty' do
          expect(response.body).to eq('[]')
        end
      end
    end
  end
end
