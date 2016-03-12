class MailchimpService

  def subscribe(email, first_name)
    gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"])
    gibbon.lists(ENV["MAILCHIMP_LIST_ID"]).members
      .create(body: {
        email_address: email,
        status: "subscribed",
        merge_fields: { FNAME: first_name }
      })
  end

end
