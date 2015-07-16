class TracksController < ApplicationController
  def show
    @track = Track.find_by(id: params[:id])

    render :show
  end

  def new
    @track = Track.new
    @album = Album.find(params[:band_id])
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(album_params)


    if @track.valid?
      @track.save
      redirect_to band_url(@track.band_id)
    else
      flash.now[:errors] = @track.errors.full_messages
      @albums ||= Album.all
      render :new
    end
  end

  def destroy
    @track = Track.find_by(id: params[:id])
    @track.destroy
    redirect_to bands_url
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :style)
  end
end
