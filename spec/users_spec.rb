require 'rails_helper'

describe Users, type: :model do

  it "validates user with valid criteria" do
    user = User.create(email: 'test@test.com', password: 'testtest', provider: 'github')
    expect(user).to be_valid
  end

  it "cannot validate user with incorrect criteria" do
    user = User.create(email: 'testtest', password: 'test', provider: 'github')
    expect(user).not_to be_valid
  end

end
