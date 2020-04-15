require 'rails_helper'

RSpec.describe 'products_page', type: :system do
  let(:product) { create(:product, taxons: [taxon]) }
  let(:taxon) { create(:taxon) }

  before do
    visit potepan_product_path(product.id)
  end

  it 'is displayed correct contents' do
    expect(page).to have_title "#{product.name} - BIGBAG Store"
    expect(page).to have_selector '.page-title', text: product.name
    expect(page).to have_link href: potepan_index_path
    expect(page).to have_content product.price
    expect(page).to have_content product.description
    expect(all('.item').size).to eq product.images.count
  end

  it 'change page after click 一覧ページへ戻る' do
    click_link '一覧ページへ戻る'
    expect(current_path).to eq potepan_category_path(product.taxons.first.id)
  end
end
