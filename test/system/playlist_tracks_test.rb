require "application_system_test_case"

class PlaylistTracksTest < ApplicationSystemTestCase
  setup do
    @playlist_track = playlist_tracks(:one)
  end

  test "visiting the index" do
    visit playlist_tracks_url
    assert_selector "h1", text: "Playlist Tracks"
  end

  test "creating a Playlist track" do
    visit playlist_tracks_url
    click_on "New Playlist Track"

    fill_in "Playlist", with: @playlist_track.playlist_id
    fill_in "Track", with: @playlist_track.track_id
    click_on "Create Playlist track"

    assert_text "Playlist track was successfully created"
    click_on "Back"
  end

  test "updating a Playlist track" do
    visit playlist_tracks_url
    click_on "Edit", match: :first

    fill_in "Playlist", with: @playlist_track.playlist_id
    fill_in "Track", with: @playlist_track.track_id
    click_on "Update Playlist track"

    assert_text "Playlist track was successfully updated"
    click_on "Back"
  end

  test "destroying a Playlist track" do
    visit playlist_tracks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Playlist track was successfully destroyed"
  end
end
