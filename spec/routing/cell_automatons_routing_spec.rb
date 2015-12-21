require "rails_helper"

RSpec.describe CellAutomatonsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cell_automatons").to route_to("cell_automatons#index")
    end

    it "routes to #new" do
      expect(:get => "/cell_automatons/new").to route_to("cell_automatons#new")
    end

    it "routes to #show" do
      expect(:get => "/cell_automatons/1").to route_to("cell_automatons#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cell_automatons/1/edit").to route_to("cell_automatons#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cell_automatons").to route_to("cell_automatons#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cell_automatons/1").to route_to("cell_automatons#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cell_automatons/1").to route_to("cell_automatons#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cell_automatons/1").to route_to("cell_automatons#destroy", :id => "1")
    end

  end
end
