require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'message validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:sender_id) }
    it { should validate_presence_of(:receiver_id) }
  end
end