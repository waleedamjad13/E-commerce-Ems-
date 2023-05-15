# frozen_string_literal: true

# controller for rendering all users and fter login users are redirect to
class HomeController < ApplicationController
  def index
    @users = User.all

  end
end
