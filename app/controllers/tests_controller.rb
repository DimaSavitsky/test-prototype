class TestsController < ApplicationController
  load_and_authorize_resource

  def index
    @tests = @tests.published
  end

end
