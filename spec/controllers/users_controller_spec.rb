require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
  @user = create_user
  end

# ensure user is logged injectdescribe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access show" do
      get :show, id: @user
      expect(response).to redirect_to('/sessions/new')
    end
    it "cannot access edit" do
      get :edit, id: @user
      expect(response).to redirect_to('/sessions/new')
    end
    it "cannot access update" do
      patch :update, id: @user
      expect(response).to redirect_to('/sessions/new')
    end
    it "cannot access destroy" do
      delete :destroy, id: @user
      expect(response).to redirect_to('/sessions/new')
    end



 # included when controller was generated:
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  #User Authorization tests
  describe "when signed in as the wrong user" do
    before do
      @wrong_user = create_user 'julius', 'julius@lakers.com'
      session[:user_id] = @wrong_user.id
    end
    it "cannot access profile page another user" do
      get :edit, id: @user
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
    end
    it "cannot update another user" do
      patch :update, id: @user
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
    end
    it "cannot destroy another user" do
      delete :destroy, id: @user
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
    end
  end

  

end
