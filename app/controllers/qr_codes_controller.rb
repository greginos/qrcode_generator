class QrCodesController < ApplicationController
  def convert
    if params[:url] && params[:image_link]
      code = QrCodeConverter.new(params[:url]).call
      @code = code.resize(400, 400)
      if params[:url].start_with?("https://open.spotify.com")
        @url = ImageFinder.new(params[:url]).find_image
      end
      @url = params[:image_link] unless @url.present?
    else    
      @code = nil
      @url = nil
    end
  end

  def export
    @code = params[:code]
    @url = params[:url]
    @kit = IMGKit.new(render_to_string)
    format .html
    format.png do
      send_data(@kit.to_png, :type => "image/png", :disposition => 'inline')
    end
  end
end
