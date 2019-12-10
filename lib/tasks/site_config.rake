namespace :site_configs do
  desc "Set site config 'web_cms' = false"
  task :standalone,  [] => :environment do |t, args|
		SiteConfig.first.update(web_cms: false)
  end
end