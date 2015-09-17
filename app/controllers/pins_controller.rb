class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]

  def index
    @pins = Pin.all
		@page_title = "Pins"
  end

  def show
		@page_title = "Pin nr. #{@pin.id}"
  end

  def new
    @pin = Pin.new
		@page_title = "New pin"
  end

  def edit
		@page_title = "Edit pin"
  end

  def create
    @pin = Pin.new(pin_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description)
    end

		def set_title 
			@page_title
		end
end
