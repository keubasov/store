require 'test_helper'

class LookTest < ActiveSupport::TestCase
  test "should get types array" do
    types = Look.product_types_for_select
    assert_includes(types, ['Постельное белье', :bedclothe])
  end
  test "should get b_materials array" do
    b_materials = Look.b_materials_for_select
    assert_includes(b_materials, ['Поплин', :poplin])
  end
end
