# Run me with: 'ruby script/clean.rb'
require 'rubygems'
require 'fileutils'

PROJECT_ROOT = File.expand_path('../..', __FILE__)
PUBLIC_ROOT = "#{PROJECT_ROOT}/public"

Dir.entries(PUBLIC_ROOT).each do |filename|
  next unless (filename != ".") && (filename != "..")
  pathed_file = "#{PUBLIC_ROOT}/#{filename}"
  if File.directory?(pathed_file)
    `rm -r #{pathed_file}`
  else
    File.delete(pathed_file)
  end
end