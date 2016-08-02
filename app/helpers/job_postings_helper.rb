module JobPostingsHelper

  def occupation_options_for(industry)
    occupations = industry&.occupations || Onet::Occupation.all

    occupations.map do |occupation|
      percent = if industry
        occupation.occupation_industries.find_by(response: industry.metadata_response).percent
      end
      [occupation.title, { percent: percent }, occupation.onetsoc_code]
    end
  end

end
