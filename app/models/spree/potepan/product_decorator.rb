module Potepan::ProductDecorator
  def related_products(count)
    Spree::Product.joins(:taxons).
      where(spree_products_taxons: { taxon_id: [taxons.ids] }).
      where.not(id: id).
      group_by { |taxon| taxon }.
      sort_by { |k, v| -v.size }.
      map(&:first).take(count)
  end
  Spree::Product.prepend self
end
