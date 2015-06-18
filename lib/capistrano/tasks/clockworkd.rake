namespace :load do
  task :defaults do
    set :clockworkd_pid, -> { File.join(current_path, 'tmp', 'clockworkd.clock.pid') }
    set :clockworkd_rb, -> { File.join(current_path, 'clock.rb') }
  end
end

namespace :clockworkd do
  desc 'Start Clockworkd'
  task :start do
    on roles(:batch) do
      within current_path do
        if test("[ -e #{fetch(:clockworkd_pid)} ] && kill -0 #{clockworkd_pid}")
          info 'clockworkd is running...'
        else
          execute :bundle, 'exec clockworkd', '-c', fetch(:clockworkd_rb), 'start', '--log'
        end
      end
    end
  end

  desc 'Stop Clockworkd (QUIT)'
  task :stop do
    on roles(:batch) do
      within current_path do
        if test("[ -e #{fetch(:clockworkd_pid)} ]")
          if test("kill -0 #{clockworkd_pid}")
            info 'stopping clockworkd...'
            execute :kill, '-s QUIT', clockworkd_pid
          else
            info 'cleaning up dead clockworkd pid...'
            execute :rm, fetch(:clockworkd_pid)
          end
        else
          info 'clockworkd is not running...'
        end
      end
    end
  end

  def clockworkd_pid
    "`cat #{fetch(:clockworkd_pid)}`"
  end
end
