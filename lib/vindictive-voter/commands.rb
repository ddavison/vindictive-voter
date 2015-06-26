# encoding: utf-8
require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: vindictive-voter [options] ...'

  opts.on('-v', '--version', 'Show the version') do
    require 'vindictive-voter/version'
    puts VindictiveVoter::VERSION
    exit
  end

  opts.on('-h', '--help', 'Show the usage') do
    puts opts
    exit
  end

  opts.on('-u USER', '--upvote', 'Upvote a user (to be used in conjuction with -c or -p') do |u|
    options[:action] = :up
    options[:user] = u
  end

  opts.on('-d USER', '--downvote', 'Downvote a user (to be used in conjunction with -c or -p') do |u|
    options[:action] = :down
    options[:user] = u
  end

  opts.on('--url URL', 'Sets the specific url to rage against') do |url|
    options[:url] = url
  end

  opts.on('--delay DELAY', 'Sets the delay between clicking the up/down vote buttons') do |delay|
    options[:delay] = delay
  end

  opts.on('--pages PAGES', 'Number of pages to go through') do |pages|
    options[:num_pages] = pages
  end

  if ARGV.size <= 0
    puts opts
    exit 1
  end

  opts.parse!
end

if options.empty?
  VindictiveVoter::Runner.new(ARGV)
else
  if options[:user] && options[:action] && options[:url]
    VindictiveVoter::Runner.new(options)
  else
    puts 'Invalid arguments.'
  end
end
