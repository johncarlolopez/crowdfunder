require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test 'A category exists' do
    category = build(:category)
    assert( category )
  end

  test 'A category exists with a specific name' do
    category = build(:category, name: "Art")
    assert_equal( "Art", category.name )
  end

end
