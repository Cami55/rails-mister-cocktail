class CocktailsController < ApplicationController
    before_action :find_cocktail, except: [:index, :new, :create]
  def index
    if params[:search].blank?
      @cocktails = Cocktail.all
    else
      @cocktails = Cocktail.where("name ilike '%#{params[:search]}%'")
    end
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktails_path
    else
      render :new
    end
  end

  def show
    @dose = Dose.new
    @doses = @cocktail.doses
  end

  def edit
    @doses = @cocktail.doses
  end

  def update
    @cocktail.update(cocktail_params)
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
