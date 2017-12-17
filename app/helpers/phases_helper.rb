module PhasesHelper
  def phase_name_class(phase)
    phase.completed? ? 'striketrough' : ''
  end

  def phase_table_row(phase)
    row_class = 'link-row'
    if phase.missed?
      row_class += ' bg-warning' 
    elsif phase.to_end_today?
      row_class += ' bg-attention'
    end

    content_tag(:tr, class: row_class, data: { href: product_phase_url(phase.product, phase) }) do
      td1 = content_tag(:td, { scope: 'row', class: phase_name_class(phase) }) do
        phase.name
      end
      
      td2 = content_tag(:td) do 
        formatted_datetime(phase.begin_at) 
      end
      
      td3 = content_tag(:td) do 
        formatted_datetime(phase.planned_end_at)
      end
      
      td4 = content_tag(:td) do 
        formatted_datetime(phase.end_at)
      end

      (td1 + td2 + td3 + td4).html_safe
    end
  end
end
