require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  poltergeist_options = {
    timeout: 20
  }
  Capybara::Poltergeist::Driver.new(app, poltergeist_options)
end

Capybara.javascript_driver = ENV.fetch("DRIVER", "poltergeist").to_sym
