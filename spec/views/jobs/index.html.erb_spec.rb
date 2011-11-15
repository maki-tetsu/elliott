require 'spec_helper'

describe "jobs/index.html.erb" do
  before(:each) do
    assign(:jobs, [
      stub_model(Job,
        :code => "Code",
        :name => "Name",
        :description => "Description",
        :customer => "Customer",
        :budget => "9.99",
        :register_id => 1,
        :register_name => "Register Name",
        :note => "MyText"
      ),
      stub_model(Job,
        :code => "Code",
        :name => "Name",
        :description => "Description",
        :customer => "Customer",
        :budget => "9.99",
        :register_id => 1,
        :register_name => "Register Name",
        :note => "MyText"
      )
    ])
  end

  it "renders a list of jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Customer".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Register Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
