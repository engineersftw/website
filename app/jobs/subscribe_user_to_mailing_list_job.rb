class SubscribeUserToMailingListJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"])
    gibbon.lists(ENV["MAILCHIMP_LIST_ID"]).members.create(body: {email_address:"#{:email_address}", first_name:"#{:first_name}, status: "subscribed")
  end
end
