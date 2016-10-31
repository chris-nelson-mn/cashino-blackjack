require 'rails_helper'

RSpec.describe PlayersController, type: :controller do

  describe "GET #action" do
    it "returns http success" do
      get :action
      expect(response).to have_http_status(:success)
    end
  end

end
