# frozen_string_literal: true

# concern for admin namespace
module AdminNamespace
  extend ActiveSupport::Concern

  def namespace
    return :admin if self.class.module_parent_class == 'Admin'

    current_user.admin? ? :admin : nil
  end
end
