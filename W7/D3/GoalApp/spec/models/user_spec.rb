# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

# session_token: "abc123", password_digest: "123abc"

RSpec.describe User, type: :model do

  subject(:malachi) {User.create!(username: "malachi", password: "abc123")}
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }
  
  describe 'find users by credentials' do
    context 'valid credentials'
      it 'return correct user' do
        jamie = User.create!(username: 'jamie', password: '123456')
        user = User.find_by_credentials('jamie', '123456')
        expect(jamie.username).to eq(user.username)
        expect(jamie.password_digest).to eq(user.password_digest)
      end

      it 'return nil when credentials are invalid' do
        jamie = User.create!(username: 'jamie', password: '123456')
        user = User.find_by_credentials('jamoo', '123456')
        expect(user).to be(nil)
      end
  end

end
