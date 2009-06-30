require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup :activate_authlogic
  
  context "companies" do   
    setup do
      UserSession.create Factory.builsd(:user)  
      @company = Factory(:company)   
    end
    
    context "view all companies" do
      setup { get :index }
    
      should_assign_to :companies
      should_respond_with :success
      should_render_template :index
    end  
  
    context "new company" do
      setup { get :new }
      
      should_render_a_form 
      should_assign_to :company
      should_respond_with :success
    end
    
    context "create company with valid data" do
      setup do
        post :create, :company =>Factory.attributes_for(:company)
      end
      
      should_assign_to :company
      should_change "Company.count", :by => 1
      should_redirect_to("company path") { company_path(Company.last) } 
      should_set_the_flash_to(/created/i)
    end  
    
    context "create company with invalid data" do
      setup { post :create, :goal => Factory.attributes_for(:company, :title => '')}

      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash 
    end
    
    context "view the company" do
      setup { get :show, :id => @company.id }
      
      should_assign_to :company
      should_respond_with :success
      should_render_template :show
    end
    
    context "edit the company" do
      setup { get :edit, :id => @company.id }
    
      should_assign_to :company
      should_respond_with :success
      should_render_template :edit
      should_not_set_the_flash
    end
    
    context "updating the company with valid data" do
      setup { put :update, :id =>@company.id, :company => Factory.attributes_for(:company, :description => 'test description')}
      
      should_assign_to :company
      should_redirect_to("company path") { company_path(@company) }
      should_set_the_flash_to(/updated/i)
    end
    
    context "updating the company with invalid data" do
      setup { put :update, :id =>@company.id, :company => Factory.attributes_for(:company, :title => '') }
      
      should_respond_with :success
      should_render_template :edit
      should_not_set_the_flash
    end  
    
    context "deleting a company" do
      setup { delete :destroy, :id => @company.id } 

      should_assign_to :company
      should_change "Company.count", :by => -1
      should_redirect_to("companies path") { companies_path }
    end    
  end
end