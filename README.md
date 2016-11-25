# Local Installation

Install Ruby 2.3.0

- gem install bundler

- bundle install

- Create `config/database.yml` and `config/carrierwave.yml` from examples

- rake db:create ; rake db:migrate

- rails s


# README

In your Bluemix console, navigate to Apps dashboard and select "Create Application", search for "Ruby" and select the option from `Cloud Foundry Apps` section.
Select the newly created app and add two services: `ElephantSQL` and `Object Storage`

For deployment: 

Download, install and authorize [Bluemix CLI](https://plugins.ng.bluemix.net/ui/home.html)

Update `manifest.yml` with your application's name and 

> bluemix cf push
