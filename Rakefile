require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'tests'
  t.libs << 'lib'
  t.test_files = FileList['tests/**/*_tests.rb']
  t.ruby_opts = ['-r "./tests/test_helper"']
end

task default: :test
