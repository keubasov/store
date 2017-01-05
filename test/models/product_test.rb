require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "should get b_materials array" do
    b_materials = Product.b_materials_for_select
    assert_includes(b_materials, ['Поплин', :poplin])
  end
  test "should get b_sizes array" do
    b_sizes = Product.b_sizes_for_select
    assert_includes(b_sizes, ['Двухспальное', :two])
  end
end
