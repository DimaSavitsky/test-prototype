module Administration
  class TestsController < AdministrationController
    load_and_authorize_resource

    def index
      @tests = @tests.includes(:test_variables)
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
      @test.assign_attributes(test_params)

      respond_to do |format|
        if @test.save
          format.html { redirect_to [:administration, @test], notice: 'Test was successfully created.' }
          format.json { render :show, status: :created, location: @test }
        else
          format.html { render :new }
          format.json { render json: @test.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      update_handler( @test.update(test_params) )
    end

    def publish
      update_handler( @test.update(published: true) )
    end

    def destroy
      @test.destroy
      respond_to do |format|
        format.html { redirect_to administration_tests_url, notice: 'Test was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def test_params
      params.require(:test).permit(
        :name, :time_limit, :randomized,
        test_variables_attributes: [:id, :name, :_destroy])
    end

    def update_handler(update_result)
      respond_to do |format|
        if update_result
          format.html { redirect_to [:administration, @test], notice: 'Test was successfully updated.' }
          format.json { render :show, status: :ok, location: @test }
        else
          format.html { render :edit }
          format.json { render json: @test.errors, status: :unprocessable_entity }
        end
      end
    end

  end
end
