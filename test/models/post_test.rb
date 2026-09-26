require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "valid with a user and body" do
    post = Post.new(user: users(:one), body: "Hello, world!")
    assert post.valid?
  end

  test "invalid without a body" do
    post = Post.new(user: users(:one), body: "")
    assert_not post.valid?
  end

  # data-model-schema.md: 500-char cap
  test "invalid with a body over 500 characters" do
    post = Post.new(user: users(:one), body: "a" * 501)
    assert_not post.valid?
  end

  test "valid with a body at exactly 500 characters" do
    post = Post.new(user: users(:one), body: "a" * 500)
    assert post.valid?
  end
end
