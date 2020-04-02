require 'rails_helper'

RSpec.describe 'product_pages', type: :system do
  subject { page }
  before do
    @product = create(:product)
    visit potepan_product_path(@product.id)
  end
  it { is_expected.to have_title "#{@product.name} - BIGBAG Store" }
  it { is_expected.to have_selector '.page-title', text: @product.name }
  it { is_expected.to have_link href: potepan_index_path }
  it { is_expected.to have_content @product.price }
  it { is_expected.to have_content @product.description }
  it 'display all product images' do
    expect(all('.item').size).to eq @product.images.count
  end
end
