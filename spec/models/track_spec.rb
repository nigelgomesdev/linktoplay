# spec/models/track.rb
require 'rails_helper'

RSpec.describe Track, type: :model do

  context 'when associating' do
    it { is_expected.to belong_to(:library) }
    it { is_expected.to belong_to(:artist) }
    it { is_expected.to have_many(:playlist_tracks) }
    it { is_expected.to have_many(:playlists).through(:playlist_tracks) }
  end

  context 'when validating' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:source_link) }
    it { is_expected.to validate_presence_of(:artist) }
  end

  describe "applying scopes" do
    let!(:track1) { create :track, title: 'Title 1', views: 10 }
    let!(:track2) { create :track, title: 'Title 2', views: 100 }

    context "when title_ordered_by asc" do
      let(:result) { Track.updated_at_ordered_by(:asc).pluck(:title) }
      it { expect(result).to eq [track1.title, track2.title] }
    end

    context "when updated_at_ordered_by desc" do
      let(:result) { Track.updated_at_ordered_by(:desc).pluck(:title) }
      it { expect(result).to eq [track2.title, track1.title] }
    end

    context "when views_ordered_by desc" do
      let(:result) { Track.views_ordered_by(:desc).pluck(:views) }
      it { expect(result).to eq [track2.views, track1.views] }
    end

    context "when popularity" do
      let(:result) { Track.popularity.pluck(:title) }
      it { expect(result).to eq [track2.title, track1.title] }
    end

    context "when title_like" do
      let(:result) { Track.title_like('2').pluck(:title) }
      it { expect(result).to eq [track2.title] }
    end

    context "when recent" do
      let(:result) { Track.recent.pluck(:title) }
      it { expect(result).to eq [track2.title, track1.title] }
    end

    context "when previous_tracks" do
      let(:result) { Track.previous_tracks(Date.tomorrow).pluck(:title) }
      it { expect(result).to eq [track2.title, track1.title] }
    end

    context "when next_tracks" do
      let(:result) { Track.next_tracks(Date.yesterday).pluck(:title) }
      it { expect(result).to eq [track1.title, track2.title] }
    end

    context "when tracks_for_user" do
      let(:result) { Track.tracks_for_user(track1.library.user.id).pluck(:title) }
      it { expect(result).to eq [track1.title] }
    end
  end

end