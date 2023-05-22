# frozen_string_literal: true

# helper for application views
module ApplicationHelper
  include Pagy::Frontend
  
  def toggle_direction(column)
    if params[:column] == column.to_s && params[:direction] == 'asc'
      'desc'
    else
      'asc'
    end
  end
  
end
