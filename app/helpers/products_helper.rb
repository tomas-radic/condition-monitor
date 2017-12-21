module ProductsHelper
  def product_class(product)
    return '' if product.archived?
    result = 'link-row'
    
    if product.phases.missed.any?
      result += ' bg-warning' 
    elsif product.phases.to_end_today.any?
      result += ' bg-attention'
    end

    result
  end
end
