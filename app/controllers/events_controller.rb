class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  

  
  

  def index
    @events = Event.all
  end

  def import
    Event.import(params[:file])
    redirect_to root_url, notice: "events imported."
  end



  def show
    @event = Event.find(params[:id])
  end


  def new
    @event = current_user.events.build(event_params)
  end

  def edit
  end

  def create
    @event = current_user.events.build(event_params)
      if @event.save
        redirect_to root_path
      else
        render action: 'new' 
      end
    end
  

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
    def update
    if  @event.update(event_params)
      redirect_to @event, notice: 'lesson was successfully updated.'
    else
      render action: 'edit'
    end
  end
  

  def destroy
    @event.destroy
    redirect_to events_url
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end
    def authenticate_user
      redirect_to pages_home_path, notice: "You must be signed in to view that page" unless user_signed_in?
    end

    def event_params
      params.require(:event).permit(:name, :details, :time1, :time2, :clock1, :clock2)
    end
end



