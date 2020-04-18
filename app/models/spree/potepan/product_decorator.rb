module Potepan::ProductDecorator
  def related_products(count)
    Spree::Product.
      includes(master: [:images, :default_price]).
      in_taxons(taxons).
      where.not(id: id).
      group_by { |taxon| taxon }.
      sort_by { |_k, v| -v.size }.
      map(&:first).take(count)
  end
  Spree::Product.prepend self
end
