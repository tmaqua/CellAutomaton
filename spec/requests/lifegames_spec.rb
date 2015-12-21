require 'rails_helper'

RSpec.describe "Lifegames", type: :request do
  describe "GET /lifegames" do
    it "works! (now write some real specs)" do
      get lifegames_path
      expect(response).to have_http_status(200)
    end
  end
end
