module Zparser
  class ZillowParser
    def import(first_page, last_page)
      zillow_result_urls(first_page, last_page).each do |url|
        ids_from_url(url).each {|zpid| HouseListing.find_or_create_by(zpid: zpid)}
        sleep(10)
        puts "Collected from a URL, sleeping for 10 seconds"
      end
      ZillowWorker.perform_async('1,10',45)
    end

    def ids_from_url(url)
      noko = Nokogiri::HTML(open(url))
      noko.css('#search-results article').collect{|article| article.attributes['id'].value.gsub('zpid_','') }
    end

    def zillow_result_urls(first_page, last_page)
      (first_page..last_page).collect {|i| "http://www.zillow.com/homes/for_sale/1-_beds/days_sort/40.344451,-103.827667,39.1684,-106.272125_rect/8_zm/#{i}_p/"}
    end
  end
end
