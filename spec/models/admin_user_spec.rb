require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  let(:admin_user) { create(:admin_user) }

  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'Factory' do
    it 'has a valid factory' do
      expect(create(:admin_user)).to be_valid
    end
  end
end
