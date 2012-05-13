# Run me with: 'ruby script/build.rb'
require 'rubygems'
require 'yaml'
require 'fileutils'
require 'cgi'

PROJECT_ROOT = File.expand_path('../..', __FILE__)
ASSETS_ROOT = "#{PROJECT_ROOT}/app/assets"
VENDOR_ROOT = "#{PROJECT_ROOT}/vendor"
TUTORIALS_ROOT = "#{PROJECT_ROOT}/app/_tutorials"

# set up structure
`cd #{PROJECT_ROOT}; mkdir public` if !File.exists?('public')

def recursiveFilteredCopy(path, filename, dest, skipped_endings)
  return if ['.', '..'].index{|ending| filename.end_with?(ending)} # skip current and up directories
  return if skipped_endings && skipped_endings.index{|ending| filename.end_with?(ending)}

  pathed_source_file = "#{path}/#{filename}"
  if File.directory?(pathed_source_file)
    return if filename.start_with?('_')
    filename = 'stylesheets' if filename == 'styles'
    filename = 'javascripts' if filename == 'scripts'
    Dir.entries(pathed_source_file).each{|child_filename| recursiveFilteredCopy(pathed_source_file, child_filename, "#{dest}/#{filename}", skipped_endings)}
  else
    `cd #{PROJECT_ROOT}; mkdir #{dest}` if !File.exists?(dest)
    `cd #{PROJECT_ROOT}; cp #{pathed_source_file} #{dest}/`
  end
end

def recursiveHTMLToEscapedText(path, filename, dest)
  return if ['.', '..'].index{|ending| filename.end_with?(ending)} # skip current and up directories

  pathed_source_file = "#{path}/#{filename}"
  if File.directory?(pathed_source_file)
    return if filename.start_with?('_')
    filename = 'stylesheets' if filename == 'styles'
    filename = 'javascripts' if filename == 'scripts'
    Dir.entries(pathed_source_file).each{|child_filename| recursiveHTMLToEscapedText(pathed_source_file, child_filename, "#{dest}/#{filename}")}
  else
    return unless (File.extname(pathed_source_file).downcase == '.html')    # only .html files

    `cd #{PROJECT_ROOT}; mkdir #{dest}` if !File.exists?(dest)

    pathed_destination_file = "#{dest}/#{filename}" + '.txt'

    # get the escaped source
    in_file = File.new(pathed_source_file, "r")
    source_buffer = CGI::escapeHTML(in_file.sysread(File.size(in_file)))
    in_file.close

    # try the copy
    begin
      # look to skip writing
      if File.exists?(pathed_destination_file)
        out_file = File.new(pathed_destination_file, "r")
        existing_buffer = out_file.sysread(File.size(out_file))
        out_file.close
        return if (source_buffer == existing_buffer)  # file has not changed
      end

      out_file = File.new(pathed_destination_file, "w")
      out_file.syswrite(source_buffer)
      out_file.close

    rescue => detail
      puts "****************FILE ERROR - BEGIN****************"
      puts detail.backtrace.join("\n")
      puts "****************FILE ERROR - END******************"
    end
  end
end

def setupDemo(root, public_target)
  # first generate the javascript and then copy any files in the TUTORIALS_ROOT over top so they can be hand crafted
  `cd #{PROJECT_ROOT}; node_modules/.bin/coffee --bare --output #{public_target} #{root}`
  Dir.entries(root).each{|filename| recursiveFilteredCopy(root, filename, public_target, ['.styl', '.coffee', '.html', '.txt', '.jade'])}
  Dir.entries(root).each{|filename| recursiveHTMLToEscapedText(root, filename, root)}
end

####################################################
# The Vendor Folder
####################################################
`cd #{PROJECT_ROOT}; mkdir public/vendor` if !File.exists?('public/vendor')
Dir.entries(VENDOR_ROOT).each{|filename| recursiveFilteredCopy(VENDOR_ROOT, filename, 'public/vendor', ['.styl', '.coffee'])}

####################################################
# The Web Site
####################################################
`cd #{PROJECT_ROOT}; mkdir public/stylesheets` if !File.exists?('public/stylesheets')
`cd #{PROJECT_ROOT}; node_modules/.bin/stylus --use nib --out public/stylesheets app/assets/styles &`

`cd #{PROJECT_ROOT}; mkdir public/javascripts` if !File.exists?('public/javascripts')
`cd #{PROJECT_ROOT}; node_modules/.bin/coffee --output public/javascripts app/assets/scripts`

Dir.entries(ASSETS_ROOT).each{|filename| recursiveFilteredCopy(ASSETS_ROOT, filename, 'public', ['.styl', '.coffee'])}

setupDemo(TUTORIALS_ROOT, 'public/tutorials')

`cd #{PROJECT_ROOT}; node_modules/.bin/jade --out public app`
