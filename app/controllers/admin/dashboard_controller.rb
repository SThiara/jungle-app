class Admin::DashboardController < ApplicationController
  def show
    @productsCount = Product.count
    @categoriesCount = Category.count
  end
end
