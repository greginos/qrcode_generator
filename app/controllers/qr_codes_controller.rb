class QrCodesController < ApplicationController
  include ActionController::MimeResponds
  
  def convert
    if params[:url] && params[:image_link]
      QrCodeConverter.new(params[:url]).call
      if params[:url].start_with?("https://open.spotify.com")
        @image_url = ImageFinder.new(params[:url]).find_image
      end
      @url = params[:url]
      @code = "/github-qrcode.png"
      @image_url = params[:image_link] unless @image_url
    else    
      @code = nil
      @url = nil
    end
  end

  def export
    @image_url = params[:image_url]
    @url = params[:url]

    first_image  = @image_url
    png = QrCodeConverter.new(params[:url]).call
  
    second_image = Rails.public_path.join("github-qrcode.png")
    processed_image = MiniMagick::Tool::Montage.new do |image|
      [first_image, second_image].each {|i| image << i unless i.empty?} 
      image.tile('1:2')
      image.geometry("x500+10+10>")
      image << Rails.public_path.join("output.jpg")        
    end
    send_file(File.open(Rails.public_path.join("output.jpg")), filename: 'qrcode.jpg', type: 'image/jpeg')
  end
end
