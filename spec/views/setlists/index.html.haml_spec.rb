require 'spec_helper'

describe "setlists/index" do
  before(:each) do
    assign(:setlists, [
      stub_model(Setlist),
      stub_model(Setlist)
    ])
  end

  it "renders a list of setlists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
