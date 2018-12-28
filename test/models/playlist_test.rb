# == Schema Information
#
# Table name: playlists
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  status     :string           default("active")
#  views      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  library_id :bigint(8)
#

require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
