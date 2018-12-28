# == Schema Information
#
# Table name: playlist_tracks
#
#  id          :bigint(8)        not null, primary key
#  playlist_id :bigint(8)
#  track_id    :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class PlaylistTrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
