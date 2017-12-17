module ProductsHelper
  def product_table_row(product)
    row_class = ''

    unless product.archived?
      row_class = 'link-row'
      href = product_url(product)
      
      if product.phases.missed.any?
        row_class += ' bg-warning' 
      elsif product.phases.to_end_today.any?
        row_class += ' bg-attention'
      end
    end

    content_tag(:tr, class: row_class, data: { href: href }) do
      td1 = content_tag(:td, { scope: 'row' }) do
        formatted_date(product.produced_at)
      end
      
      td2 = content_tag(:td) do 
        product.name 
      end
      
      td3 = content_tag(:td) do 
        product.label 
      end
      
      td4 = content_tag(:td) do 
        formatted_date(product.expiration_at) 
      end

      (td1 + td2 + td3 + td4).html_safe
    end
  end
end
