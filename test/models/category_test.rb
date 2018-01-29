require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'A category exists' do
    Category.create(name: "Art")
    expected = "Art"
    actual = Category.first.name

    assert_equal(expected, actual)
  end

end
