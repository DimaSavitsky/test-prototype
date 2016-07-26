module Administration
  class TestResultsController < AdministrationController
    load_and_authorize_resource :test, :update
    before_action :set_test_variable
    before_action :set_test_result, only: [:edit, :update]

    def edit
    end

    def update
      respond_to do |format|
        if @test_result.update(test_result_params)
          format.html { redirect_to [:administration, @test], notice: 'Test Results were successfully updated.' }
          format.json { render :show, status: :ok, location: @test }
        else
          format.html { render :edit }
          format.json { render json: @test_result.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_test_variable
      @test_variable = @test.test_variables.find(params[:test_variable_id])
    end

    def set_test_result
      @test_result = @test_variable.test_result || TestResult.new(test_variable_id: @test_variable.id)
    end

    def test_result_params
      params.require(:test_result).permit(
        :internal_ability_id,
        test_result_ranges_attributes: [:id, :range_start, :range_stop, :attribute_score, :result_message, :_destroy]
      )
    end

  end
end
