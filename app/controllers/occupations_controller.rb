class OccupationsController < ApplicationController
  authorize_resource class: false

  def index
    criteria = current_user.user_internal_abilities.collected_search_criteria
    @occupations = Onet::Occupation.search(criteria)
  end

end
