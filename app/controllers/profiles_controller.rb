class ProfilesController < ApplicationController
  authorize_resource class: false

  def show
    @test_results = current_user.test_attempts.completed.includes(:test)
  end

  def edit
  end

  def update
    current_user.update(profile_attributes)

    redirect_to :profile
  end

  private

  def profile_attributes
    params.require(:user).permit(user_internal_abilities_attributes: [:id, :internal_ability_id, :level, :_destroy])
  end

end
