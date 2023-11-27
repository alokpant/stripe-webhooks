require "test_helper"

class BillingsControllerTest < ActionDispatch::IntegrationTest
  test "should get stripe_portal" do
    get billings_stripe_portal_url
    assert_response :success
  end
end
