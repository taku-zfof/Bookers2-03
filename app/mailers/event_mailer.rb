class EventMailer < ApplicationMailer

  def event_email(event,users,from)
    @event=event
    @from=from
    users.each do|user|
      mail(
        to: user.email,
        from: from.email
      )
    end
  end

end
