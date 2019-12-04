namespace :site_config do
  desc "Set site config 'web_cms' = false"
  task :web_cms,  [] => :environment do |t, args|
  	SiteConfig.first.update(web_cms: true)
  end
end