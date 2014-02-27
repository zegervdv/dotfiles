require 'rake'


desc 'Update plugins'
task :update do
  sh 'git submodule foreach git checkout master'
  sh 'git submodule foreach git pull --rebase'
end
