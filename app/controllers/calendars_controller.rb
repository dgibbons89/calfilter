class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  def index
    @calendars = calendar.all
  end

    def import
    begin
      calendar.import(params[:file])
      redirect_to root_url, notice: "Products imported."
    rescue
      redirect_to root_url, notice: "Invalid CSV file format."
    end
  end



  def show
    @calendar = calendar.find(params[:id])
  end


  def new
    @calendar = current_user.calendars.build(calendar_params)
  end

  def edit
  end

  def create
    @calendar = current_user.calendars.build(calendar_params)
      if @calendar.save
        redirect_to root_path
      else
        render action: 'new' 
      end
    end
  

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
    def update
    if  @calendar.update(calendar_params)
      redirect_to @calendar, notice: 'lesson was successfully updated.'
    else
      render action: 'edit'
    end
  end
  

  def destroy
    @calendar.destroy
    redirect_to calendars_url
  end

  private
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    def calendar_params
      params.require(:calendar).permit(:name, :year)
    end
end
