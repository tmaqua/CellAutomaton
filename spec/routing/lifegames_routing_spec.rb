require "rails_helper"

RSpec.describe LifegamesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/lifegames").to route_to("lifegames#index")
    end

    it "routes to #new" do
      expect(:get => "/lifegames/new").to route_to("lifegames#new")
    end

    it "routes to #show" do
      expect(:get => "/lifegames/1").to route_to("lifegames#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/lifegames/1/edit").to route_to("lifegames#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/lifegames").to route_to("lifegames#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/lifegames/1").to route_to("lifegames#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/lifegames/1").to route_to("lifegames#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/lifegames/1").to route_to("lifegames#destroy", :id => "1")
    end

  end
end
