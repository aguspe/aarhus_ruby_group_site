class EventsController < ApplicationController
  def index
    @upcoming_events = Event.published.upcoming
    @past_events = Event.published.past
  end

  def show
    @event = Event.published.find_by!(slug: params[:id])
    @rsvp = Current.member&.rsvps&.find_by(event: @event)
    @attendees = @event.rsvps.yes.includes(:member)
  end
end
