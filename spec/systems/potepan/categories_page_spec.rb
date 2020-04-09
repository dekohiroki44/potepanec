require 'rails_helper'

RSpec.describe 'categories_page', type: :system do
  let(:taxon) { create(:taxon) }
  let!(:product) { create(:product, taxons: [taxon]) }
  let!(:taxonomy_test) { create(:taxonomy, name: 'Categories') }
  let!(:taxon_test) { create(:taxon, taxonomy: taxonomy_test) }

  before do
    taxon_test = taxonomy_test.taxons.leaves.first
    visit potepan_category_path(taxon.id)
  end

  it 'is displayed correct contents' do
    expect(page).to have_title "#{taxon.name} - BIGBAG Store"
    expect(page).to have_selector '.page-title', text: taxon.name
    expect(page).to have_link href: potepan_index_path
    expect(page).to have_content product.name
    expect(page).to have_content product.price
  end

  it 'change page after click product' do
    click_link "#{product.name}"
    expect(current_path).to eq potepan_product_path(product.id)
  end

  it 'show link of taxonomy or taxon in product_category' do
    within '.product-category' do
      click_link "#{taxonomy_test.name}"
      expect(page).to have_link taxon_test.name, href: potepan_category_path(taxon_test.id)
    end
  end
end
