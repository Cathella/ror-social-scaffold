require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) { User.create(name: 'joper', email: 'jsjxxs@jsjsee.com', password: 'passworddd') }
  let(:user2) { User.create(name: 'jopexxr', email: 'jsjs@jsjsee.com', password: 'passworddd') }
  let(:rec) { user1.friendships.build(friend_id: user2.id, confirmed: false) }

  context 'Associations' do
    it { should belong_to(:friend).class_name('User') }
    it { should belong_to(:user) }
  end

  context 'Validations' do
    it 'is valid with valid attributes' do
      expect(rec).to be_valid
    end

    it 'is invalid if friend does not exist' do
      rec2 = Friendship.new(friend_id: 100, user_id: user1.id, confirmed: false)
      expect(rec2).to_not be_valid
    end
  end
end
