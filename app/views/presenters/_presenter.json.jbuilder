json.id presenter.id
json.name presenter.name.to_s
json.byline presenter.byline.to_s
json.avatar_url presenter.avatar.to_s
json.url presenter_name_slug_url(name: presenter.name.parameterize, id: presenter.id)
json.website presenter.website.to_s
json.twitter presenter.twitter.to_s
json.biography presenter.biography.to_s