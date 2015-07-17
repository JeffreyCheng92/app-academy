class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)

    redirect_to track_url(@note.track_id) if @note.save
  end

  def update

  end

  def destroy

  end

  private

  def note_params
    params.require(:note).permit(:user_id, :track_id)
  end

end
