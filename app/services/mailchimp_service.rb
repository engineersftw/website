class MailchimpService
  attr_reader :gibbon

  def initialize(gibbon=nil)
    @gibbon = gibbon || Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"])
  end

  def subscribe(email, first_name)
    gibbon
      .lists(ENV["MAILCHIMP_LIST_ID"])
      .members
      .create(body: {
        email_address: email,
        status: "subscribed",
        merge_fields: { FNAME: first_name }
      })
  end

end
