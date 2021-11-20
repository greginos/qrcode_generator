class QrCodesController < ApplicationController
  def convert
    @code = QrCodeConverter.new(params[:url]).call
    send_data(@code, type: 'image/png')
  end
end
