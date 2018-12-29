# frozen_string_literal: true

# HomeController
class HomeController < ApplicationController
  load_and_authorize_resource :library, only: [:index], parent: false

  def index
    # TODO: handle multiple libraries
    @first_library = Library.accessible_by(current_ability).try(:first)
    @first_library.present? && recent_playlists && recent_tracks
  end

  def search_type
    (search_path = redirect_search_path) && (return redirect_to search_path)
  end

  private

  def search_type_params
    params.require(:search_type).permit(:type, q: {})
  end

  def search_params
    { q: (search_type_params[:q] || {}) }
  end

  def redirect_search_path
    case search_type_params[:type]
    when 'playlists'
      playlists_path(search_params)
    when 'tracks'
      tracks_path(search_params)
    when 'artists'
      artists_path(search_params)
    end
  end

  def recent_playlists
    @recent_playlists = @first_library.playlists.recent.limit(5).page(0)
  end

  def recent_tracks
    @recent_tracks = @first_library.tracks.recent.limit(5).page(0)
  end
end
