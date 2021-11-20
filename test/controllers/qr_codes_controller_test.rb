require 'test_helper'

class QrCodesControllerTest < ActionDispatch::IntegrationTest
  test "should get convert" do
    get qr_codes_convert_url
    assert_response :success
  end

end
