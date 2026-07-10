class ProductsController < ApplicationController
  def index
    @categories = Category.order(:name)
    @products = Product.available.includes(:categories).order(:name)

    if params[:category_id].present?
      @products = @products.joins(:categories).where(categories: { id: params[:category_id] })
    end

    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @products = @products.where("products.name LIKE ? OR products.description LIKE ?", keyword, keyword)
    end

    if params[:filter] == "sale"
      @products = @products.on_sale
    elsif params[:filter] == "new"
      @products = @products.new_arrivals
    end

    @products = @products.page(params[:page]).per(6)
  end

  def show
    @product = Product.find(params[:id])
  end
end