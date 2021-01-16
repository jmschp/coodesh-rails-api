class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @products = policy_scope(Product)
    authorize @products, :index?
  end
end
