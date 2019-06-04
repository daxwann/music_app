require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:activation_digest) }
  end

  describe 'associations' do
  end

  describe 'class methods' do
  end
end
