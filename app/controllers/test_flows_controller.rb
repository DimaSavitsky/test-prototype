class TestFlowsController < ApplicationController
  load_and_authorize_resource :test

  before_filter :set_test_flow_service

  def show
  end

  def goto_question
    @flow_service.goto(params[:question_index])
    redirect_to [@test, :test_flow]
  end

  def set_response
    if @flow_service.update_response(variant_params[:variant_id])
      @flow_service.goto( @flow_service.next_question_index )
    else
      flash[:error] = @flow_service.current_response.errors.full_messages
    end
    redirect_to [@test, :test_flow]
  end

  def finalize
    @flow_service.finalize
    redirect_to( controller: :test_results, action: :show, id: @flow_service.test_attempt_id )
  end

  private

  def set_test_flow_service
    @flow_service = TestFlowService.new( user: current_user, test: @test )
  end

  def variant_params
    params.require(:variant).permit(:variant_id)
  end

end
