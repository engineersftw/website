repo = Feature::Repository::YamlRepository.new("#{Rails.root}/config/feature.yml", Rails.env)
Feature.set_repository repo
