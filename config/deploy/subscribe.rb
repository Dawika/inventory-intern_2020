set :application, 'somsri'
server '150.95.25.211', user: 'deploy', roles: %w{app db web}
set :branch, ENV['BRANCH'] || 'master'
set :deploy_to, '/srv/www/apps/somsri'