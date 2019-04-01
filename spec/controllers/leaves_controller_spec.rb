require 'rails_helper'
RSpec.describe LeavesController, type: :controller do
  include Devise::Test::ControllerHelpers
  include Warden::Test::Helpers
  include Devise::Test::IntegrationHelpers
  Warden.test_mode!

  describe "authenticated employee" do
    before(:all) do
      login_as(employee, scope: :employee)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "it should create a new leave" do
        @request.env['devise.mapping'] = Devise.mappings[:employee]
        @current_employee = create(:employee)
        sign_in :employee
        leave_quotum = create(:leave_quotum)
        leave = Leave.create(employee_id: @current_employee.id , to: '09/07/2019', from: '07/07/2019', reason: "not feeling well", leave_quotum_id: leave_quotum.id)
      end
    end
  end

  describe "GET #new" do
    context "with valid attributes" do
      it "it should build a new leave object" do
        leave = Leave.new
      end
    end
  end

  describe "GET index" do
    it "it assigns @leaves of current employee" do
      @request.env['devise.mapping'] = Devise.mappings[:employee]
      @current_employee = create(:employee)
      sign_in :employee
      leaves = Leave.all.where(employee_id: @current_employee.id)
      get :index
      expect(response).to have_http_status(:found)
    end
  end
end