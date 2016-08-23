require 'bundler/gem_tasks'
require 'rake/testtask'

task default: :test

desc 'test'
task :test do
  [:newtest, :newtest_aef, :newtest_finite_set, :newtest_mathn].each do |task|
    Rake::Task[task].invoke
  end
end

Rake::TestTask.new(:newtest) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test-*.rb']
  t.verbose = true
end

Rake::TestTask.new(:newtest_aef) do |t|
  t.libs << 'test/aef'
  t.test_files = FileList['test/aef/test-*.rb']
  t.verbose = true
end

Rake::TestTask.new(:newtest_finite_set) do |t|
  t.libs << 'test/finite-set'
  t.test_files = FileList['test/finite-set/test-*.rb']
  t.verbose = true
end

Rake::TestTask.new(:newtest_mathn) do |t|
  t.libs << 'test/mathn'
  t.test_files = FileList['test/mathn/test-*.rb']
  t.verbose = true
end

Dir.glob('test/**/test*.rb') do |file|
  Rake::TestTask.new(file) do |t|
    t.libs << 'test'
    t.test_files = FileList[file]
    t.verbose = true
  end
end
