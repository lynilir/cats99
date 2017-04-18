class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy
    redirect_to cats_url, notice: "Delete success"
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :birth_date, :description)
  end
end
