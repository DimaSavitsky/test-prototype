class ProfilesController < ApplicationController
  authorize_resource class: false

  def show
    @test_results = current_user.test_attempts.completed.includes(:test)
  end

end
