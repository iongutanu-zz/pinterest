class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
  before_filter :check_configuration

  def index
    @pins = Pin.all
		@page_title = "Pins"
  end

  def show
		@page_title = "Pin nr. #{@pin.id}"
  end

  def new
    @pin = current_user.pins.build
		@page_title = "New pin"
  end

  def edit
		@page_title = "Edit pin"
  end

  def create
    @pin = current_user.pins.build(pin_params)
		@page_title = "Create new pin"

      if @pin.save
        redirect_to @pin, notice: 'Pin was successfully created.'
      else
        render :new
      end
  end

  def update
      if @pin.update(pin_params)
        redirect_to @pin, notice: 'Pin was successfully updated.'
      else
        frender :edit
      end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url, notice: 'Pin was successfully destroyed.'
  end

  def check_configuration
    redirect_to root_path, notice: 'Cloudinary configuration missing !' if Cloudinary.config.api_key.blank?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

		def correct_user
			@pin = current_user.pins.find_by(id: params[:id])
			redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
		end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image)
    end

		def set_title 
			@page_title
		end
end
