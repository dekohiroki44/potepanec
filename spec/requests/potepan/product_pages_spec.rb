require 'rails_helper'

RSpec.describe 'product_pages', type: :request do
  describe "GET #show" do
    before do
      @product = create(:product)
    end

    it "returns http success" do
      get potepan_product_path(@product.id)
      expect(response).to have_http_status(:success)
    end
  end
end
