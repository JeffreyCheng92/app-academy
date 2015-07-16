class AlbumsController < ApplicationController
  def show
    @album = Album.find_by(id: params[:id])

    render :show
  end

  def new
    @album = Album.new
    @band = Band.find(params[:band_id])
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)


    if @album.valid?
      @album.save
      redirect_to band_url(@album.band_id)
    else
      flash.now[:errors] = @album.errors.full_messages
      @bands ||= Band.all
      render :new
    end
  end

  def destroy
    @album = Album.find_by(id: params[:id])
    @album.destroy
    redirect_to bands_url
  end

  private
  def album_params
    params.require(:album).permit(:title, :band_id, :style)
  end

end
