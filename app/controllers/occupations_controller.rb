class OccupationsController < ApplicationController
  layout 'full-width'
  authorize_resource class: false

  before_filter :set_user_abilities

  def index
    if @user_abilities.present?
      criteria = @user_abilities.collected_search_criteria
      @occupations = Onet::Occupation.search(criteria)
    else
      redirect_to profile_path, notice: 'You need to set your Abilities'
    end
  end

  private

  def set_user_abilities
    @user_abilities = current_user.user_internal_abilities
  end

end
