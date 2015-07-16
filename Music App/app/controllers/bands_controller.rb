class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find_by(id: params[:id])

    render :show
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
  end

  def destroy
    @band = Band.find(id: params[:id])
    @band.destroy
  end

end
