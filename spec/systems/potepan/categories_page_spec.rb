require 'rails_helper'

RSpec.describe 'categories_page', type: :system do
  let(:taxon) { create(:taxon) }
  let!(:product) { create(:product, taxons: [taxon]) }
  let!(:taxonomy_category) { create(:taxonomy, name: 'Categories') }
  let!(:taxonomy_brand) { create(:taxonomy, name: 'Brand') }
  let!(:taxon_shoes) do
    create(:taxon, name: 'shoes',
                   taxonomy: taxonomy_category,
                   parent_id: taxonomy_category.taxons.first.id)
  end
  let!(:taxon_PHP) do
    create(:taxon, name: 'PHP',
                   taxonomy: taxonomy_brand,
                   parent_id: taxonomy_brand.taxons.first.id)
  end

  before do
    visit potepan_category_path(taxon.id)
  end

  it 'displays correct contents' do
    expect(page).to have_title "#{taxon.name} - BIGBAG Store"
    expect(page).to have_selector '.page-title', text: taxon.name
    expect(page).to have_link href: potepan_index_path
    expect(page).to have_content product.name
    expect(page).to have_content product.price
  end

  it 'changes page after click product' do
    click_link "#{product.name}"
    expect(current_path).to eq potepan_product_path(product.id)
  end

  describe 'in product cutegory', js: true do
    it 'displays link of taxon that belongs to taxonomy after click taxonomy ' do
      within '.product-category' do
        click_link "#{taxonomy_category.name}"
        expect(page).to have_link taxon_shoes.name, href: potepan_category_path(taxon_shoes.id)
        expect(page).not_to have_link taxon_PHP.name
      end
    end
  end
end
