set :application, 'somsri'
server '172.104.43.99', user: 'deploy', roles: %w{app db web}
set :branch, ENV['BRANCH'] || 'Subscribe'
set :deploy_to, '/srv/www/apps/somsri'