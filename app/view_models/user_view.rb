# frozen_string_literal: true

# UserView class for users show
#
class UserView < ApplicationView
  alias user model

  delegate :firstname, :lastname, :email, :admin?, :confirmed?, to: :user

  def toggle_direction(column, current_column, current_direction)
    if column.to_s == current_column && current_direction == 'asc'
      'desc'
    else
      'asc'
    end
  end
end
