require 'rails_helper'

RSpec.describe 'products_page', type: :system do
  let(:product) { create(:product, taxons: [taxon_1, taxon_2]) }
  let(:taxon_1) { create(:taxon) }
  let(:taxon_2) { create(:taxon) }
  let!(:taxon_3) { create(:taxon) }
  let!(:product_most_related) { create(:product, name: 'most_related', taxons: [taxon_1, taxon_2]) }
  let!(:product_related_1) { create(:product, name: 'related_1', taxons: [taxon_1]) }
  let!(:product_related_2) { create(:product, name: 'related_2', taxons: [taxon_1]) }
  let!(:product_related_3) { create(:product, name: 'related_3', taxons: [taxon_1]) }
  let!(:product_related_4) { create(:product, name: 'related_4', taxons: [taxon_1]) }
  let!(:product_not_related) { create(:product, name: 'not_related', taxons: [taxon_3]) }

  before do
    visit potepan_product_path(product.id)
  end

  it 'displays correct contents' do
    expect(page).to have_title "#{product.name} - BIGBAG Store"
    expect(page).to have_selector '.page-title', text: product.name
    expect(page).to have_link href: potepan_index_path
    expect(page).to have_content product.price
    expect(page).to have_content product.description
    expect(all('.item').size).to eq product.images.count
  end

  it 'changes page after click 一覧ページへ戻る' do
    click_link '一覧ページへ戻る'
    expect(current_path).to eq potepan_category_path(product.taxons.first.id)
  end

  describe 'in related products' do
    it 'displays 4 related products' do
      within '.productsContent' do
        expect(first('.productBox')).to have_content product_most_related.name
        expect(page).to have_selector '.productBox', count: 4
      end
    end
    it 'does not display not related product' do
      expect(page).not_to have_content product_not_related.name
    end
  end
end
