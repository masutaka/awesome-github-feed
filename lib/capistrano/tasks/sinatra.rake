namespace :load do
  task :defaults do
    set :sinatra_log, -> { shared_path.join('log', 'app.log') }
    set :sinatra_pid, -> { shared_path.join('tmp', 'pids', 'app.pid') }
    set :sinatra_rb, -> { current_path.join('app.rb') }
  end
end

namespace :sinatra do
  desc 'Start Sinatra'
  task :start do
    on roles(:app) do
      within current_path do
        if test("[ -e #{fetch(:sinatra_pid)} ] && kill -0 #{sinatra_pid}")
          info 'sinatra is running...'
        else
          execute :bundle, 'exec ruby', fetch(:sinatra_rb), '-e production >>', fetch(:sinatra_log), '2>&1 &'
        end
      end
    end
  end

  desc 'Stop Sinatra (INT)'
  task :stop do
    on roles(:app) do
      within current_path do
        if test("[ -e #{fetch(:sinatra_pid)} ]")
          if test("kill -0 #{sinatra_pid}")
            info 'stopping sinatra...'
            execute :kill, '-s INT', sinatra_pid
          else
            info 'cleaning up dead sinatra pid...'
            execute :rm, fetch(:sinatra_pid)
          end
        else
          info 'sinatra is not running...'
        end
      end
    end
  end

  def sinatra_pid
    "`cat #{fetch(:sinatra_pid)}`"
  end
end
