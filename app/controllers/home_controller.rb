class HomeController < ApplicationController
  load_and_authorize_resource :library, only: [:index], parent: false

  def index
    #TODO: handle multiple libraries
    @first_library = Library.accessible_by(current_ability).try(:first)
    if @first_library.present?
      @recent_playlists = @first_library.playlists.recent.limit(5).page(0)
      @recent_tracks = @first_library.tracks.recent.limit(5).page(0)
    end
  end

  def search_type
    case search_type_params[:type]
    when 'playlists'
      return redirect_to playlists_path(search_params)
    when 'tracks'
      return redirect_to tracks_path(search_params)
    when 'artists'
      return redirect_to artists_path(search_params)
    end
  end

  private
  def search_type_params
    params.require(:search_type).permit(:type, q: {})
  end

  def search_params
    {q: (search_type_params[:q] || {})}
  end
end
