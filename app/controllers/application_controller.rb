# frozen_string_literal: true

# controller for methods that are used in all controllers
class ApplicationController < ActionController::Base
  include AuthorizeUser

  include AdminNamespace
end
