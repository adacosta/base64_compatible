require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

desc "benchmark"
task :benchmark do |b|
  require 'base64'
  require 'benchmark'
  require 'lib/base64_compatible'
  require 'test/strings'
  include Strings

  n = 5000
  encoded_login_string = Base64Compatible.encode64(LOGIN_STRING)
  puts ""
  Benchmark.bm do |x|
    x.report("Base64.encode64") { n.times do; Base64.encode64(LOGIN_STRING); end }
    x.report("Base64Compatible.encode64") { n.times do ; Base64Compatible.encode64(LOGIN_STRING); end }
    x.report("Base64.decode64") { n.times do; Base64.decode64(encoded_login_string); end }
    x.report("Base64Compatible.decode64") { n.times do ; Base64Compatible.decode64(encoded_login_string); end }
  end
end