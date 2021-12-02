class QrCodesController < ApplicationController
  def convert
    if params[:url] && params[:image_link]
      code = QrCodeConverter.new(params[:url]).call
      @code = code.resize(400, 400)
      @url = params[:image_link]
    else    
      @code = nil
      @url = nil
    end
  end
end
