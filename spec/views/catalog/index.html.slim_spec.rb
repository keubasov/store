require 'rails_helper'

feature 'catalog/index', type: :view do
  before(:each) do
    create(:look, :bedclothe, :unbleached_calico, name: 'Бязь')
    create(:look, :bedclothe, :poplin, name: 'Поплин')
  end
  scenario 'when visit catalog/index path' do
    visit root_path
    expect(page).to have_css('h2', text: 'Бязь')
  end
end
# RSpec.describe "products/index", type: :view do
#   before(:each) do
#     assign(:products, [
#       Product.create!(),
#       Product.create!()
#     ])
#   end
#
#   it "renders a list of products" do
#     render
#   end
# end