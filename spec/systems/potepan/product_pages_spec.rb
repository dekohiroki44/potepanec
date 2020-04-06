require 'rails_helper'

RSpec.describe 'product_pages', type: :system do
  let(:product) { create(:product) }

  it 'is displayed correct contents' do
    visit potepan_product_path(product.id)
    expect(page).to have_title "#{product.name} - BIGBAG Store"
    expect(page).to have_selector '.page-title', text: product.name
    expect(page).to have_link href: potepan_index_path
    expect(page).to have_content product.price
    expect(page).to have_content product.description
    expect(all('.item').size).to eq product.images.count
  end
end
