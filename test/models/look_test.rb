require 'test_helper'

class ProductNameTest < ActiveSupport::TestCase
  test "should get types array" do
    types = Look.product_types_for_select
    assert_includes(types, ['Постельное белье', :bedclothe])
  end
end
