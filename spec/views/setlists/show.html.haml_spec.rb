require 'spec_helper'

describe "setlists/show" do
  before(:each) do
    @setlist = assign(:setlist, stub_model(Setlist))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
