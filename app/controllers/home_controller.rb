# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :have_current_user

  def index; end
end
