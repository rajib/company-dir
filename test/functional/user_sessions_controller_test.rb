require 'test_helper'
require "authlogic/test_case"

class UserSessionsControllerTest < ActionController::TestCase
  setup :activate_authlogic

  context "new action" do
    should "render new template when not logged in" do
      get :new
      assert_template 'new'
    end

    should "redirect to account page when logged in" do
      UserSession.create Factory.build(:user)
      get :new
      assert_redirected_to account_url
    end
  end

  context "create action" do
    should "render new template when authentication is invalid" do
      UserSession.stubs(:create).returns(nil)
      post :create
      assert_template 'new'
      assert_nil UserSession.find
    end

    should "redirect when authentication is valid" do
      UserSession.create Factory.build(:user)
      post :create
      assert_redirected_to account_url
      assert_not_nil UserSession.find
    end
  end

  context "destroy action" do
    context "when user is logged in" do
      setup do
        UserSession.create Factory.build(:user)
        post :destroy
      end

      should "not have session" do
        assert_nil UserSession.find
      end

      should_set_the_flash_to "Logout successful!"
      should_redirect_to('login page') { new_user_session_url }
    end

    context "when user isn't logged in" do
      setup do
        post :destroy
      end

      should_set_the_flash_to "You must be logged in to access this page"
      should_redirect_to('login page') { new_user_session_url }
    end
  end
end
