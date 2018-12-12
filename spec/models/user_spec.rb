require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @valid_user = User.new(email: 'foo@bar.com', password: 'foobar33')
    @invalid_user = User.new
    @no_password_user = User.new(email: 'tom@tom.com')
  end

  it 'has an email field' do
    expect(User.new).to respond_to(:email)
  end
  
  it 'has a password field' do
    expect(User.new).to respond_to(:password)
  end

  it 'is invalid without an email' do
    expect(@invalid_user.valid?).to be_falsey
  end

  it 'is invalid without a password' do
    expect(@no_password_user.valid?).to be_falsey
  end
end
