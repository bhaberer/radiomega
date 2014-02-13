require 'spec_helper'

describe "setlists/new" do
  before(:each) do
    assign(:setlist, stub_model(Setlist).as_new_record)
  end

  it "renders new setlist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", setlists_path, "post" do
    end
  end
end
