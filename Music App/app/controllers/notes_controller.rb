class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.save
    redirect_to track_url(@note.track_id)
  end

  def update

  end

  def destroy
    @note = Note.find_by(id: params[:id])
    @track_id = @note.track_id
    if current_user.id == @note.user_id
      @note.destroy
      redirect_to track_url(@track_id)
    else
      head: 403
    end
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :track_id, :note)
  end

end
