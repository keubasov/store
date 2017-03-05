require 'rails_helper'

# RSpec.describe "products/edit", type: :view do
#   before(:each) do
#     @product = assign(:product, Product.create!())
#   end
#
#   it "renders the edit product form" do
#     render
#
#     assert_select "form[action=?][method=?]", product_path(@product), "post" do
#     end
#   end
# end
# scenario 'user can delete own account' do
#   skip 'skip a slow test'
#   user = FactoryGirl.create(:user)
#   login_as(user, :scope => :user)
#   visit edit_user_registration_path(user)
#   click_button 'Cancel my account'
#   page.driver.browser.switch_to.alert.accept
#   expect(page).to have_content I18n.t 'devise.registrations.destroyed'
# end