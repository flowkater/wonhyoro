# encoding: UTF-8
class EventsController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @teasers = @event.teasers
    @imageable = @event
    @images = @imageable.pictures.most_recent
    @image = Picture.new
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])

    if @event.save
      redirect_to @event, notice: 'event was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to @event, notice: 'event was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_url
  end
end
