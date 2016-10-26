class DishesController < ApplicationController
  before_action :set_dish, only: [:show, :edit, :update, :destroy]
  before_action :set_country, only: [:index, :new, :create]

  # GET /dishes
  # GET /dishes.json
  def index
    @dishes = Dish.all
  end

  # GET /dishes/1
  # GET /dishes/1.json
  def show
  end

  # GET countries/:id/dishes/new
  def new
    @dish = Dish.new
  end

  # GET /dishes/1/edit
  def edit
    @country = Dish.find(params[:id]).country_id
  end

  # POST countries/:id/dishes
  # POST countries/:id/dishes.json
  def create
    @dish = Dish.new(dish_params)
    @dish.country_id = @country.id

    respond_to do |format|
      if @dish.save
        format.html { redirect_to @dish, notice: 'Dish was successfully created.' }
        format.json { render :show, status: :created, location: @dish }
      else
        format.html { render :new }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dishes/1
  # PATCH/PUT /dishes/1.json
  def update
    respond_to do |format|
      if @dish.update(dish_params)
        format.html { redirect_to @dish, notice: 'Dish was successfully updated.' }
        format.json { render :show, status: :ok, location: @dish }
      else
        format.html { render :edit }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes/1
  # DELETE /dishes/1.json
  def destroy
    @country = @dish.country.id
    @dish.destroy
    respond_to do |format|
      format.html { redirect_to dishes_url, notice: 'Dish was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @dish = Dish.find(params[:id])
    end
    def set_country
      @country = Country.find(params[:country_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dish_params
      params.require(:dish).permit(:title, :recipe, :country_id)
    end
end
