require "rails_helper"

RSpec.describe CatalogController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => root_path).to route_to("catalog#index")
    end

    it "routes to #show" do
      expect(:get => "/catalog/1").to route_to("catalog#show", :id => "1")
    end


  end
end
