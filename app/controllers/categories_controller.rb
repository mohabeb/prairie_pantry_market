class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.available.order(:name).page(params[:page]).per(6)
  end
end