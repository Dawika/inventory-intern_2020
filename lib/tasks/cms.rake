namespace :db do
  namespace :cms do
    desc "Prepare data for CMS"
    task :seeds,  [] => :environment do |t, args|
      SiteConfig.update(web_cms: true)
      if Comfy::Cms::Site.count == 0
        Comfy::Cms::Site.create!({label: 'Somsri School', identifier: 'somsri-landing', hostname: 'localhost', locale: 'en', is_mirrored: 'f'})
      end
    end
  end
end
