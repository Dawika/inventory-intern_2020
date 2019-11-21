Rake::Task['deploy:assets:precompile'].clear

namespace :deploy do
  namespace :assets do
    desc 'Precompile assets locally and then rsync to remote servers'
    task :precompile do
      %x{bundle exec rake assets:precompile assets:clean}

      local_manifest_path = %x{ls -a public/assets/.*manifest*}.strip
      on roles(fetch(:assets_roles)) do |server|
        %x{rsync -avr --exclude='.DS_Store' ./public/assets/ #{server.user}@#{server.hostname}:#{release_path}/public/assets/}
        %x{rsync -avr --exclude='.DS_Store' ./#{local_manifest_path} #{server.user}@#{server.hostname}:#{release_path}/assets_manifest#{File.extname(local_manifest_path)}}
      end

      %x{bundle exec rake assets:clobber}
    end
  end
end
