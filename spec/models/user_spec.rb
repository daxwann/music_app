require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user, password: 'starwars') }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:activation_token) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
  end

  describe 'class methods' do
    describe '#is_password?' do
      it 'returns true for correct password' do
        expect(user.is_password?('starwars')).to eq(true)  
      end

      it 'returns false for incorrect password' do
        expect(user.is_password?('startrek')).to eq(false)
      end
    end

    describe '::find_by_credentials' do
      before { user.save! }
      it 'returns correct user with correct credentials' do
        expect(User.find_by_credentials(user.email, 'starwars')).to eq(user)
      end

      it 'returns nil with incorrect credentials' do
        expect(User.find_by_credentials(user.email, 'startrek')).to eq(nil)
      end
    end

    describe '#reset_session_token!' do
      it 'changes old session token' do
        old_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).to_not eq(old_token)
      end
    end
  end
end
