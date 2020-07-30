require 'rails_helper'

RSpec.describe User, type: :model do
  let(:sender) { User.new(email: 'jj@gmail.com', name: 'joe', password: 'joirun3jdws') }
  let(:receiver) { User.new(email: 'nelly@gmail.com', name: 'jane', password: 'joirusn3jdws') }

  context 'Associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships).with_foreign_key('friend_id').class_name('Friendship') }
    it { should have_many(:accepted_friendships).conditions(confirmed: true).with_foreign_key('user_id').class_name('Friendship') }
    it { should have_many(:accepted_inverse_friendships).conditions(confirmed: true).with_foreign_key('friend_id').class_name('Friendship') }
    it { should have_many(:pending_friendships).conditions(confirmed: nil).with_foreign_key('user_id').class_name('Friendship') }
    it { should have_many(:pending_friends).through(:pending_friendships).source(:friend).with_foreign_key('friend_id') }
    it { should have_many(:received_friendships).conditions(confirmed: nil).with_foreign_key('friend_id').class_name('Friendship') }
    it { should have_many(:friend_requests).through(:received_friendships).source(:user).with_foreign_key('user_id') }
    it { should have_many(:friends).through(:friendships) }
  end

  context 'Validations' do
    it 'is valid with valid attributes' do
      sender.email = 'coal@jj.com'
      expect(sender).to be_valid
    end

    it 'is not valid without a name' do
      receiver.name = nil
      expect(receiver).to_not be_valid
    end

    it { should validate_length_of(:name).is_at_most(20) }
    it { should validate_presence_of(:name) }
  end
end
