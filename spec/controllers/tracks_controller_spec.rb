# spec/controllers/tracks_controller_spec.rb
require 'rails_helper'

RSpec.describe TracksController, type: :controller do
  let(:user) { create :user }
  before do
    user.confirm
    sign_in user
  end
  let(:library) { create :library, user: user }

  describe "GET #index" do
    let!(:track1) { create :track, title: 'Title 1', views: 10, library: library }
    let!(:track2) { create :track, title: 'Title 2', views: 100, library: library }

    it "assigns @tracks" do
      get :index
      expect(assigns(:tracks)).to eq([track1, track2])
    end

    it "renders #index" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    let!(:track1) { create :track, title: 'Title 1', views: 10, library: library }
    let!(:response) { get :show, params: { id: track1.id } }

    it "assigns @track" do
      expect(assigns(:track)).to eq(track1)
    end

    it "increments views" do
      expect(assigns(:track).views).to eq(track1.views+1)
    end

    it "renders #show" do
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigned @track new_record?" do
      get :new
      expect(assigns(:track).new_record?).to eq true
    end

    it "renders #new" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:track1)  { build :track, library: library }

    it "creates a new Track" do
      expect{
        post :create, params: { track: track1.attributes }
      }.to change(Track, :count).by(1)
    end

    it "assigned @track valid?" do
      post :create, params: { track: track1.attributes }
      expect(assigns(:track).valid?).to eq true
    end

    it "redirects to #show" do
      post :create, params: { track: track1.attributes }
      expect(response).to redirect_to(assigns(:track))
    end
  end

  describe "GET #edit" do
    let!(:track1) { create :track, title: 'Title 1', views: 10, library: library }
    let!(:response) { get :edit, params: { id: track1.id } }

    it "assigned @track exists" do
      expect(assigns(:track).present?).to eq true
    end

    it "renders #edit" do
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT #update" do
    let!(:track1)  { create :track, library: library }
    let!(:response) { put :update, params: { id: track1, track: track1.attributes.merge({title: 'Title 2'}) } }

    it "updates an existing Track" do
      expect(assigns(:track).title).to eq 'Title 2'
    end

    it "assigned @track valid?" do
      expect(assigns(:track).valid?).to eq true
    end

    it "redirects to #show" do
      expect(response).to redirect_to(assigns(:track))
    end
  end

  describe "DELETE #destroy" do
    let!(:track1)  { create :track, library: library }

    it "deletes the Track" do
      expect{
        delete :destroy, params: { id: track1 }
      }.to change(Track, :count).by(-1)
    end

    it "redirects to #index" do
      delete :destroy,  params: { id: track1 }
      expect(response).to redirect_to(tracks_url)
    end
  end

end