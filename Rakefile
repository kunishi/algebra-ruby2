require 'rake/testtask'

task default: :test

desc 'test'
task :test do
    Dir.glob('test/test*.rb') do |file|
        Rake::Task[file].invoke
    end
end

Dir.glob('test/test*.rb') do |file|
    Rake::TestTask.new(file) do |t|
        t.libs << 'test'
        t.test_files = FileList[file]
        t.verbose = true
    end
end
