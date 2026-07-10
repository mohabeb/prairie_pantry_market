class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:customer, :province, order_items: :product).order(created_at: :desc)
  end
end