# frozen_string_literal: true

# concern for pagy gem
module PagyHelpers
  extend ActiveSupport::Concern
  included { include Pagy::Backend }
end
