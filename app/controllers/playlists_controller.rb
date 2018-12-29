# frozen_string_literal: true

# PlaylistsController
class PlaylistsController < ApplicationController
  before_action :set_playlist, only: %i[show edit update destroy]
  before_action :set_library
  load_and_authorize_resource

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.accessible_by(current_ability)
                         .includes(:tracks)
                         .scoped(search_params)
                         .page(params[:page])
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show; end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
    @playlist.tracks.build
  end

  # GET /playlists/1/edit
  def edit; end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.new(playlist_params)
    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to @playlist, notice: 'Playlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def set_library
    @library = current_user.try(:library)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def playlist_params
    params.require(:playlist).permit(
      :title, :status, :views, :library_id,
      tracks_attributes: [:id, :title, :artist_id, :genre, :source_link, :library_id]
    )
  end

  def search_params
    params[:q] || {}
  end
end
