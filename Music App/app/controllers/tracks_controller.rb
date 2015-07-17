class TracksController < ApplicationController
  before_action :log_in_check
  
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
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      @albums ||= Album.all
      render :new
    end
  end

  def edit
    @track = Track.find_by(id: params[:id])
    @album_id = @track.album_id
    @albums = Album.all
    render :edit
  end

  def update
    @track = Track.find_by(id: params[:id])

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      @album_id ||= @track.album_id
      @albums ||= Album.all
      flash.now[errors] = @track.errors.full_messages
      render :edit
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
    params.require(:track).permit(:name, :album_id, :style, :lyrics)
  end
end
