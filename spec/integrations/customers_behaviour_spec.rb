require 'rails_helper'

feature 'users behaviors' do
  scenario 'user buys a product' do
    visit root_path
    expect(page).to have_css('h1',text: Бязь)

  end
end
