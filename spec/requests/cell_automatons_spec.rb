require 'rails_helper'

RSpec.describe "CellAutomatons", type: :request do
  describe "GET /cell_automatons" do
    it "works! (now write some real specs)" do
      get cell_automatons_path
      expect(response).to have_http_status(200)
    end
  end
end
