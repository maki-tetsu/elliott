require "spec_helper"

describe :routes do
  context "GET /" do 
    subject { { get: "/" } }

    it { should route_to(controller: "user_sessions", action: "new") }
  end

  describe "user_sessions" do 
    context "GET /user_session/new" do 
      subject { { get: "/user_session/new" } }
      
      it { should route_to(controller: "user_sessions", action: "new") }
    end

    context "POST /user_session" do 
      subject { { post: "/user_session" } }
      
      it { should route_to(controller: "user_sessions", action: "create") }
    end

    context "DELETE /user_session" do 
      subject { { delete: "/user_session" } }
      
      it { should route_to(controller: "user_sessions", action: "destroy") }
    end

    context "GET /sign_in" do 
      subject { { get: "/sign_in" } }

      it { should route_to(controller: "user_sessions", action: "new") }
    end

    context "POST /authenticate" do 
      subject { { post: "/authenticate" } }

      it { should route_to(controller: "user_sessions", action: "create") }
    end

    context "POST /sign_out" do 
      subject { { post: "/sign_out" } }

      it { should route_to(controller: "user_sessions", action: "destroy") }
    end
  end
end
