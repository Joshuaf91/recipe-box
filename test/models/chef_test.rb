require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: "john", email: "something@gmail.com")
  end

  test "chef should be vaild" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = " " 
    assert_not @chef.valid?
  end

  test "chefname length should not be > 40 charecters" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "length should not be < 3 charecters" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email should be with in bounds" do
    @chef.email = "a" * 101 + "@gmail.com"
    assert_not @chef.valid?
  end

  test "email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email should accept valid email" do
    valid_email = %w[user@eee.com something.yeah@gmial.some.com joshua@gmail.com first.last@gmail.com yessy_robles@gmail.com]
    valid_email.each do |validEmail|
      @chef.email = validEmail
      assert @chef.valid?, "#{validEmail.inspect} should be valid"
    end
  end

  test "email should reject invalid email" do
    invalid_email = %w[userateee.com something.yeah@gmial,some.com joshuagmail.com first.last@gmailcom tonysomehelp.com]
    invalid_email.each do |invalidEmail|
      @chef.email = invalidEmail
      assert_not @chef.valid?, "#{invalidEmail.inspect} should be invalid"
    end
  end
end