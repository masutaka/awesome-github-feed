require 'pushover'

namespace :pushover do
  namespace :deploy do
    task :finished do
      invoke 'pushover:deploy:notify', 'Success', 'normal'
    end

    task :failed do
      invoke 'pushover:deploy:notify', 'Failed', 'high'
    end

    task :notify, [:result, :priority] do |task, args|
      next unless ENV['CIRCLECI']

      repo_full_name = "#{ENV['CIRCLE_PROJECT_USERNAME']}/#{ENV['CIRCLE_PROJECT_REPONAME']}"
      message  = "#{args[:result]}: #{ENV['CIRCLE_USERNAME']}'s build "
      message += "(##{ENV['CIRCLE_BUILD_NUM']}) in #{repo_full_name} (#{ENV['CIRCLE_BRANCH']})"
      url = "https://circleci.com/gh/#{repo_full_name}/#{ENV['CIRCLE_BUILD_NUM']}"

      Pushover.notification(
        user:     ENV['PUSHOVER_USER_TOKEN'],
        token:    ENV['PUSHOVER_APP_TOKEN'],
        device:   'iPhone',
        priority: args[:priority],
        title:    "deploy to #{ENV['CIRCLE_PROJECT_REPONAME']}",
        message:  message,
        url:      url,
      )
    end
  end
end

after 'deploy:finished', 'pushover:deploy:finished'
after 'deploy:failed', 'pushover:deploy:failed'
