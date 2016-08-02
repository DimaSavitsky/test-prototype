class JobPostingsController < ApplicationController

  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @job_posting.assign_attributes(user: current_user)

    respond_to do |format|
      if @job_posting.save
        format.html { redirect_to @job_posting, notice: 'Job posting was successfully created.' }
        format.json { render :show, status: :created, location: @job_posting }
      else
        format.html { render :new }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_posting.update(job_posting_params)
        format.html { redirect_to @job_posting, notice: 'Job posting was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_posting }
      else
        format.html { render :edit }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_posting.destroy
    respond_to do |format|
      format.html { redirect_to job_postings_url, notice: 'Job posting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def industry_occupations
    industry = InternalIndustry.find_by(id: params[:industry_id])
    render partial: 'occupation_options', locals: { occupations: industry&.occupations || Onet::Occupation.all }
  end

  def specifics
    job_posting = JobPosting.find_by(id: params[:posting_id])
    occupation = Onet::Occupation.find_by(onetsoc_code: params[:onetsoc_code])

    posting_to_render = if job_posting && job_posting.onetsoc_code == occupation.onetsoc_code
                          job_posting
                        else
                          JobPosting.new(onet_occupation: occupation)
                        end

    render(partial: 'job_specifics', locals: {
      occupation: occupation,
      job_posting: posting_to_render
    })
  end

  private

  def job_posting_params
    scoped_param = params[:job_posting]
    scoped_param[:abilities] = scoped_param[:abilities].values
    scoped_param[:tasks] = scoped_param[:tasks].values

    params.require(:job_posting).permit( :onetsoc_code, :title, :description, abilities: [], tasks: [] )
  end

end
