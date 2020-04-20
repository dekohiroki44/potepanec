module Potepan::ProductDecorator
  def related_products(count)
    Spree::Product.
      includes(master: [:images, :default_price]).
      in_taxons(taxons).
      where.not(id: id).
      group(:id).
      order(Arel.sql("count(*) desc")).
      limit(count)
  end
  Spree::Product.prepend self
end
