module Zparser
  class ZillowScraper
    def populate_property
      property = Rubillow::HomeValuation.zestimate({ :zpid => zpid })
      if property.success?
        string = "http://www.zillow.com/webservice/GetZestimate.htm?zws-id=#{ENV['ZWSID']}&zpid=#{zpid}"
        listing = Net::HTTP.get(URI.parse("http://www.zillow.com/webservice/GetZestimate.htm?zws-id=#{ENV['ZWSID']}&zpid=#{zpid}"))
      end
      doc = Nokogiri::XML(listing)
      begin
        self.street = doc.at('street').content
        self.zipcode = doc.at('zipcode').content
        self.city = doc.at('city').content
        self.state = doc.at('state').content
        self.latitude = doc.at('latitude').content
        self.longitude = doc.at('longitude').content
        self.price = doc.at('amount[currency]').content
        self.home_link = doc.at('homedetails').content
        self.save!
      rescue
        puts "FUCK YOU! #{self}"
      end
    end
  end
end
