class TracksController < ApplicationController
  def show
    @track = Track.find_by(id: params[:id])

    render :show
  end

  def new
    @track = Track.new
    @album = Album.find(params[:album_id])
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(track_params)


    if @track.valid?
      @track.save
      redirect_to album_url(@track.album_id)
    else
      flash.now[:errors] = @track.errors.full_messages
      @albums ||= Album.all
      render :new
    end
  end

  def destroy
    @track = Track.find_by(id: params[:id])
    @album = @track.album_id
    @track.destroy
    redirect_to album_url(@album)
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :style)
  end
end
