require './spec/rails_helper'

describe User, type: :model do

  it 'is not valid with a incomplete email address' do
    user = User.new(email: "1234")
    expect(user).to have(1).error_on(:email)
    expect(user).not_to be_valid
  end

  it 'is not valid with a only an email address' do
    user = User.new(email: "fake@example.com")
    expect(user).not_to be_valid
  end

  it 'is not valid with a only a password' do
    user = User.new(password: "123456")
    expect(user).not_to be_valid
  end

  it 'is not valid with a password less than 6 chars' do
    user = User.new(email: "fake@example.com", password: "1234")
    expect(user).to have(1).error_on(:password)
    expect(user).not_to be_valid
  end

  it 'is valid with a password (min 6 chars) and email' do
    user = User.new(email: "fake@example.com", password: "123456")
    expect(user).to be_valid
  end

end
