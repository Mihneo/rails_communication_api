require 'rails_helper'

RSpec.describe 'User', type: :request do
  let(:users) { FactoryBot.create_list(:user, 4) }
  let(:test_user) { FactoryBot.create(:user, username: 'Test user') }

  before(:each) { users << test_user}

  describe 'index' do
    it 'should return the list of users correctly' do
      get users_path
      expect(response).to be_successful
      expect(response.body).to include('Test user')
    end
  end

  describe 'show' do
    it 'should return the requested user' do
      get user_path(test_user)
      expect(response).to be_successful
      expect(response.body).to include('Test user')
    end
  end

  describe 'delete' do
    it 'should delete the user' do
      delete user_path(test_user)
      expect(response).to be_successful
    end
  end

  describe 'create' do
    new_user_data = { user: { username: 'New user', email: Faker::Internet.email,
                              password: Faker::FunnyName.unique.name } }

    it 'should create the user' do
      post users_path(new_user_data)
      expect(response).to be_successful
      expect(response.body).to include('New user')
    end
  end
end