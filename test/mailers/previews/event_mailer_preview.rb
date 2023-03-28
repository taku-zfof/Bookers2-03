# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview

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
