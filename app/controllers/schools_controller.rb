class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]

    def index
    @schools = school.all
  end

    def import
    begin
      school.import(params[:file])
      redirect_to root_url, notice: "Products imported."
    rescue
      redirect_to root_url, notice: "Invalid CSV file format."
    end
  end



  def show
    @school = school.find(params[:id])
  end


  def new
    @school = current_user.schools.build(school_params)
  end

  def edit
  end

  def create
    @school = current_user.schools.build(school_params)
      if @school.save
        redirect_to root_path
      else
        render action: 'new' 
      end
    end
  

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
    def update
    if  @school.update(school_params)
      redirect_to @school, notice: 'lesson was successfully updated.'
    else
      render action: 'edit'
    end
  end
  

  def destroy
    @school.destroy
    redirect_to schools_url
  end

  private
    def set_school
      @school = School.find(params[:id])
    end

    def school_params
      params.require(:school).permit(:school, :zipcode, :calendar_id)
    end
end
