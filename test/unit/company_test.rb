require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  should_validate_presence_of :title
  
  should_belong_to :user
end
