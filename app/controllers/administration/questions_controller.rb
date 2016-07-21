module Administration
  class QuestionsController < AdministrationController
    load_and_authorize_resource :test, :update
    before_action :set_question, only: [:edit, :update, :destroy]

    def new
      @question =  @test.questions.new
    end
  
    def edit
    end
  
    def create
      @question = @test.questions.new(question_params)
  
      respond_to do |format|
        if @question.save
          format.html { redirect_to administration_test_url(@test), notice: 'Question was successfully created.' }
          format.json { render :show, status: :created, location: @question }
        else
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      respond_to do |format|
        if @question.update(question_params)
          format.html { redirect_to administration_test_url(@test), notice: 'Question was successfully updated.' }
          format.json { render :show, status: :ok, location: @question }
        else
          format.html { render :edit }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @question.destroy
      respond_to do |format|
        format.html { redirect_to administration_test_url(@test), notice: 'Question was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      def set_question
        @question = @test.questions.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def question_params
        params.require(:question).permit(:text, :test_variable_id, question_responses_attributes: [:id, :text, :points, :_destroy])
      end
  end
end
