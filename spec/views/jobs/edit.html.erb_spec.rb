require 'spec_helper'

describe "jobs/edit.html.erb" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :code => "MyString",
      :name => "MyString",
      :description => "MyString",
      :customer => "MyString",
      :budget => "9.99",
      :register_id => 1,
      :register_name => "MyString",
      :note => "MyText"
    ))
  end

  it "renders the edit job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path(@job), :method => "post" do
      assert_select "input#job_code", :name => "job[code]"
      assert_select "input#job_name", :name => "job[name]"
      assert_select "input#job_description", :name => "job[description]"
      assert_select "input#job_customer", :name => "job[customer]"
      assert_select "input#job_budget", :name => "job[budget]"
      assert_select "input#job_register_id", :name => "job[register_id]"
      assert_select "input#job_register_name", :name => "job[register_name]"
      assert_select "textarea#job_note", :name => "job[note]"
    end
  end
end
