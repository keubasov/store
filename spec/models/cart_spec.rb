require 'rails_helper'

RSpec.describe Cart, type: :model do
  #relationships
  it {should have_many(:line_items)}
end
