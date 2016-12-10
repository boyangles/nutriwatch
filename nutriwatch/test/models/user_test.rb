require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "test", email: "test@test.com")
	end

	test "should be true" do
		assert @user.valid?
	end
  # test "the truth" do
  #   assert true
  # end
end
