class ProfilesController < ApplicationController
  layout 'full-width', only: [:static_1]
  authorize_resource class: false

  before_filter :set_profile_record, only: [:edit, :update, :static_1, :static_2, :static_3]

  def show
    @test_results = current_user.test_attempts.completed.order(completed_at: :desc).limit(8).includes(:test)
  end

  def edit
  end

  def update
    if @profile.update(profile_attributes)
      redirect_to :profile, notice: 'Abilities updated.'
    else
      render :edit
    end
  end

  def static_1
  end

  def static_2
  end

  def static_3
  end

  private

  def set_profile_record
    @profile = current_user
  end

  def profile_attributes
    params.require(:user).permit(user_internal_abilities_attributes: [:id, :internal_ability_id, :level, :_destroy])
  end

end
