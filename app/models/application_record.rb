# frozen_string_literal: true

# model for common logic for all models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
