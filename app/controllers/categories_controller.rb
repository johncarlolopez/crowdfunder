class CategoriesController < ApplicationController

  def show
    @projects = Category.find(params[:id]).projects.all

  end

end
