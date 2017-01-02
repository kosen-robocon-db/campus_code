require 'pp'
require 'net/http'
require 'json'

module CampusCode

  class Geocoder

    BASE_URL = "https://maps.googleapis.com/maps/api/place/textsearch/json"

    def initialize
      @API_KEY = ENV["GOOGLE_PLACES_API_KEY"]
    end

    def get_coordinates(query)
      coordinates = { latitude: nil, longtitude: nil }
      encoded_query = URI.encode(query)
      url = "#{BASE_URL}?query=#{encoded_query}&language=ja&key=#{@API_KEY}"
      uri = URI.parse(url)
      begin
        response = Net::HTTP.get_response(uri)
        case response
        when Net::HTTPSuccess then
          data = JSON.parse(response.body)
          location = data['results'][0]['geometry']['location'] rescue nil
          if location && location.size == 2
            coordinates[:latitude] = (location['lat'].to_f).round(8)
            coordinates[:longtitude] = (location['lng'].to_f).round(8)
          end
        else
          puts [uri.to_s, response.value].join(" : ")
        end
      rescue => e
        puts [uri.to_s, e.class, e].join(" : ")
      end
      coordinates
    end

  end

end
