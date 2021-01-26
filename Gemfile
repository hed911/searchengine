source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'
gem 'rails', '~> 6.1.1'
gem 'puma', '~> 5.0'
gem 'httparty'
gem 'figaro'
gem 'redis'
# gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false
# gem 'rack-cors'
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.2'
end
group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end
group :test do
  gem 'capybara'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
