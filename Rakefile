require 'rake/testtask'

task default: :test

desc 'test all'
task :test do
  chdir('test') do
    system "make"
  end
end

Rake::TestTask.new(:newtest) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test-*.rb']
  t.verbose = true
end
