class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize

  def index
    @products = Product.order(:title)
    change_visit_count
  end

  def change_visit_count
    if session[:visit_counter].nil?
      session[:visit_counter] = 0
    end
    session[:visit_counter] += 1
    @visit_counter = session[:visit_counter]
  end

end
