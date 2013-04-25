require 'rubygems'
require 'bundler/setup'

Bundler.setup

require 'uglifier'

desc "Compile"
task :compile do
  system("bundle exec coffee -c -o ./build ./src")
  File.open('./build/idle.min.js', 'w') { |f| f.write Uglifier.compile(File.read('./build/idle.js')) }
end