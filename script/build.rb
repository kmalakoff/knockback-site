# Run me with: 'ruby script/build.rb'
require 'rubygems'
require 'yaml'
require 'fileutils'

PROJECT_ROOT = File.expand_path('../..', __FILE__)
ASSETS_ROOT = "#{PROJECT_ROOT}/app/assets"
VENDOR_ROOT = "#{PROJECT_ROOT}/vendor"
SKIPPED_ENDINGS = ['.', '..', '.styl']

# set up structure
`cd #{PROJECT_ROOT}; mkdir public` if !File.exists?('public')

def recursiveFilteredCopy(path, filename, dest)
  pathed_file = "#{path}/#{filename}"
  return if SKIPPED_ENDINGS.index{|ending| pathed_file.end_with?(ending)}
  if File.directory?(pathed_file)
    filename = 'stylesheets' if filename == 'styles'
    filename = 'javascripts' if filename == 'scripts'
    Dir.entries(pathed_file).each{|child_filename| recursiveFilteredCopy(pathed_file, child_filename, "#{dest}/#{filename}")}
  else
    `cd #{PROJECT_ROOT}; mkdir #{dest}` if !File.exists?(dest)
    `cd #{PROJECT_ROOT}; cp #{pathed_file} #{dest}/`
  end
end

####################################################
# The Web Site
####################################################
`cd #{PROJECT_ROOT}; node_modules/.bin/jade --out public app`
`cd #{PROJECT_ROOT}; mkdir public/stylesheets` if !File.exists?('public/stylesheets')
`cd #{PROJECT_ROOT}; node_modules/.bin/stylus --use nib --out public/stylesheets app/assets/styles &`

Dir.entries(ASSETS_ROOT).each{|filename| recursiveFilteredCopy(ASSETS_ROOT, filename, 'public')}

####################################################
# The Vendor Folder
####################################################
`cd #{PROJECT_ROOT}; mkdir public/vendor` if !File.exists?('public/vendor')
Dir.entries(VENDOR_ROOT).each{|filename| recursiveFilteredCopy(VENDOR_ROOT, filename, 'public/vendor')}