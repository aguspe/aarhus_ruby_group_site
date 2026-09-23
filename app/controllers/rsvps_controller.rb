class RsvpsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_event

  def create
    @rsvp = Current.member.rsvps.find_or_initialize_by(event: @event)
    @rsvp.status = params[:status] || :yes
    @rsvp.save!

    respond_to do |format|
      format.html { redirect_to event_path(@event), notice: rsvp_notice }
      format.turbo_stream
    end
  end

  def update
    @rsvp = Current.member.rsvps.find_by!(event: @event)
    @rsvp.update!(status: params[:status])

    respond_to do |format|
      format.html { redirect_to event_path(@event), notice: rsvp_notice }
      format.turbo_stream
    end
  end

  def destroy
    @rsvp = Current.member.rsvps.find_by!(event: @event)
    @rsvp.destroy!

    respond_to do |format|
      format.html { redirect_to event_path(@event), notice: "RSVP cancelled." }
      format.turbo_stream
    end
  end

  private

  def set_event
    @event = Event.published.find_by!(slug: params[:event_id])
  end

  def rsvp_notice
    case @rsvp.status
    when "yes" then "You're attending! See you there."
    when "maybe" then "Marked as maybe."
    when "no" then "Got it, maybe next time!"
    end
  end
end
