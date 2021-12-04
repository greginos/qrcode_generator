require 'open-uri'
require 'nokogiri'

class ImageFinder
    def initialize(url)
        @url = url
    end

    def find_image
        html_file = URI.open(@url).read
        html_doc = Nokogiri::HTML(html_file)
        photo_url = html_doc.search("meta[property='og:image']").first.attributes['content'].value
    end
end