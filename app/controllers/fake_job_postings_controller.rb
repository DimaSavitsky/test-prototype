class FakeJobPostingsController < ApplicationController
  authorize_resource class: false

  def index
  end

  def fake_new
  end

  def fake_preview
  end

end
