require "spec_helper"

describe SetlistsController do
  describe "routing" do

    it "routes to #index" do
      get("/setlists").should route_to("setlists#index")
    end

    it "routes to #new" do
      get("/setlists/new").should route_to("setlists#new")
    end

    it "routes to #show" do
      get("/setlists/1").should route_to("setlists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/setlists/1/edit").should route_to("setlists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/setlists").should route_to("setlists#create")
    end

    it "routes to #update" do
      put("/setlists/1").should route_to("setlists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/setlists/1").should route_to("setlists#destroy", :id => "1")
    end

  end
end
