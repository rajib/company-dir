require 'test_helper'

Factory.define :user do |u|
  u.login 'foobar'
  u.password pw = 'foo123!@#'
  u.password_confirmation pw
end

class UserTest < ActiveSupport::TestCase

  setup do
    User.delete_all
  end

  context "when user object exists" do 
    setup do
      Factory(:user)
    end

    should_ensure_length_at_least :login, 4
    should_ensure_length_at_least :password, 7
    should_validate_uniqueness_of :login
  end

  should "be valid" do
    assert Factory.build(:user).valid?
  end

  should "not allow odd characters in login" do
    assert !Factory.build(:user, :login => "odd ^&(@)'\"!").valid?
  end


  should "require matching password confirmation" do
    assert !Factory.build(:user, :password_confirmation => "nope").valid?
  end

  should "generate hash and salt on create" do
    user = Factory(:user)
    assert user.crypted_password
    assert user.password_salt
  end
end
