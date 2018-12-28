# == Schema Information
#
# Table name: tracks
#
#  id          :bigint(8)        not null, primary key
#  title       :string
#  status      :string           default("active")
#  genre       :string
#  artist_id   :bigint(8)
#  source_id   :bigint(8)
#  source_link :string
#  views       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  library_id  :bigint(8)
#

require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
