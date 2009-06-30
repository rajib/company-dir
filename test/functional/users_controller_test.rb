require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup :activate_authlogic
  
  context "new action" do
    setup do 
      get :new
    end
    
    should_render_template 'new'
  end

  context "create action" do
    should "render new template when model is invalid" do
      User.any_instance.stubs(:valid?).returns(false)
      post :create
      assert_template 'new'
    end

    should "redirect when model is valid" do
      User.any_instance.stubs(:valid?).returns(true)

      user = Factory.build(:user)
      User.stubs(:new).returns(user)

      post :create
      assert_redirected_to account_url
    end
  end

  context "show action" do
    context "when user is not logged in" do
      setup do
        get :show
      end

      should_redirect_to('login page') { new_user_session_url }
    end
    
    context "when user is logged in" do
      setup do
        UserSession.create Factory.build(:user)
        get :show
      end
      
      should_render_template 'show'
    end
  end

  context 'edit action' do
    context "when user is not logged in" do
      setup do
        get :edit
      end

      should_redirect_to('login page') { new_user_session_url }
    end

    context "when user is logged in" do
      setup do
        UserSession.create Factory.build(:user)
        get :edit
      end

      should_render_template 'edit'
    end
  end

  context 'update action' do
    context "when user is not logged in" do
      setup do
        post :update
      end

      should_redirect_to('login page') { new_user_session_url }
    end

    context "when user is logged in" do
      setup do
        UserSession.create Factory.build(:user)
        post :update, :user => {:password => 'newpassword', :password_confirmation => 'newpassword'}
      end

      should_set_the_flash_to 'Account updated!'
      should_redirect_to("user's page") { account_url }
    end
  end
end
