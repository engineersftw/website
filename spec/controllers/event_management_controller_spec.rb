require 'rails_helper'

RSpec.describe EventManagementController, type: :controller do

  describe "GET #index" do
    before do
      FactoryGirl.create :event
    end

    it "returns http success" do
      get :index

      expect(response).to have_http_status(:success)
      expect(assigns(:events).count).to be > 0
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:event)).to be_a(Event)
      expect(assigns(:webuild_events).count).to be > 0
    end
  end

  describe "GET #create" do
    let(:webuild_id){ '12345' }

    before do
      events_response = [
          { 'id' => webuild_id, 'group_id' => '240211686', 'platform' => 'facebook', 'name' => 'Some Event', 'rsvp_count' => 200 }
      ]
      allow_any_instance_of(WebuildEventsService).to receive(:get_events).and_return(events_response)
    end

    it "returns http success" do
      post :create, {event: {webuild_id: webuild_id}}

      expect(response).to redirect_to(event_management_index_path)

      new_event = Event.last
      expect(new_event.webuild_id).to eq webuild_id
      expect(new_event.name).to eq 'Some Event'
    end
  end

  xdescribe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe "GET #update" do
    it "returns http success" do
      put :update
      expect(response).to have_http_status(:success)
    end
  end

end
