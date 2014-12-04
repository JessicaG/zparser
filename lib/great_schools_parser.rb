module FmnhGem
  class GreatSchoolsParser
    def school_list
      Faraday.get("http://api.greatschools.org/schools/nearby?key=#{ENV['GSCHOOLID']}&city=Denver&state=CO")
    end

    def schools
      doc = Nokogiri::XML(school_list.body)
      doc.css('school')
    end

    def build_schools
      schools.each do |school|
        SchoolListing.build_from_doc(school)
      end
    end

    def self.build_from_doc(school)
      begin
        attrs = {
          gsid: school.at('gsId').content,
          name: school.at('name').content,
          school_rating: school.at('gsRating').content,
          #parent_rating: school.at('parentRating').content,
          #school_type: school.at('type').content,
          grade_range: school.at('gradeRange').content,
          city: school.at('city').content,
          state: school.at('state').content,
          #districtID: school.at('districtId').content,
          #districtName: school.at('district').content,
          street_address: school.at('address').content,
          phone: school.at('phone').content,
          #website: school.at('website').content,
          latitude: school.at('lat').content,
          longitude: school.at('lon').content
        }
      rescue
      end
      new(attrs).save
    end

  end
end
