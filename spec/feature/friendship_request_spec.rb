require 'rails_helper'

RSpec.describe Friendship, type: :feature do
  let(:person1) { User.create(name: 'Sharon', email: 'piexioeexa@hh.com', password: 'i8juejj41A') }

  let(:person2) { User.create(name: 'John', email: 'pix33xa@hh.com', password: 'i2e8juejj41A') }

  describe 'friendship requests' do
    let(:person1) { User.create(name: 'Sharon', email: 'piexioeexa@hh.com', password: 'i8juejj41A') }
    let(:person2) { User.create(name: 'John', email: 'pix33xa@hh.com', password: 'i2e8juejj41A') }

    def log_in(user)
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on 'Log in'
    end

    def send_request(friend)
      visit users_path
      find('li', text: "#{friend.name}").click_link('Invite')
    end

    context 'sending a friend request' do
      it 'sends a friend request' do
        sender = person1
        receiver = person2
        log_in(sender)
        send_request(receiver)
        expect(page).to have_content 'friend request sent.'
      end

      it 'sender should have pending request' do
        sender = person1
        receiver = person2
        log_in(sender)
        send_request(receiver)
        expect(sender.pending_friends.count).to eql(1)
      end
    end
  end
end
