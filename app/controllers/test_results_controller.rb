class TestResultsController < ApplicationController
  load_and_authorize_resource class: TestAttempt

  def show
  end

end
