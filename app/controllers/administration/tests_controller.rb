module Administration
  class TestsController < AdministrationController
    before_action :set_test, only: [:show, :edit, :update, :destroy]

    def index
      @tests = Test.includes(:test_variables).all
    end

    def show
    end

    def new
      @test = Test.new
    end

    def edit
    end

    def create
      @test = Test.new(test_params)

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
      respond_to do |format|
        if @test.update(test_params)
          format.html { redirect_to [:administration, @test], notice: 'Test was successfully updated.' }
          format.json { render :show, status: :ok, location: @test }
        else
          format.html { render :edit }
          format.json { render json: @test.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @test.destroy
      respond_to do |format|
        format.html { redirect_to administration_tests_url, notice: 'Test was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_test
      @test = Test.find(params[:id])
    end

    def test_params
      params.require(:test).permit(:name, test_variables_attributes: [:id, :name, :_destroy])
    end

  end
end
