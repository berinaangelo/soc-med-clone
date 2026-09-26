require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "invalid without a name" do
    user = User.new(email: "new@example.com", password: "password123", name: "")
    assert_not user.valid?
  end

  test "valid with a name, email, and password" do
    user = User.new(email: "new@example.com", password: "password123", name: "New User")
    assert user.valid?
  end
end
