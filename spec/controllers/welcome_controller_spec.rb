require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  xdescribe "#events" do
    it "fetches events from WeBuild" do
      get :events

      expect(assigns(:events)).to_not be_empty
      expect(assigns(:events).first["name"]).to eq "Julia Deep Dive"
      expect(assigns(:events).first.keys).to include *%w(id name location url formatted_time group_name)
    end
  end
end
