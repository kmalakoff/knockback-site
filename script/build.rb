# Run me with: 'ruby script/build.rb'
require 'rubygems'
require 'yaml'
require 'fileutils'
require 'cgi'

PROJECT_ROOT = File.expand_path('../..', __FILE__)
ASSETS_ROOT = "#{PROJECT_ROOT}/app/assets"
VENDOR_ROOT = "#{PROJECT_ROOT}/vendor"
TUTORIALS_ROOT = "#{PROJECT_ROOT}/app/_tutorials"
GETTING_STARTED_ROOT = "#{PROJECT_ROOT}/app/_getting_started"
SAMPLE_APPLICATIONS = "#{PROJECT_ROOT}/app/_sample_applications"

# set up structure
`rm -rf public` if File.exists?('public')
`cd #{PROJECT_ROOT}; mkdir public` if !File.exists?('public')

def recursiveFilteredCopy(path, filename, dest, skipped_endings)
  return if ['.', '..'].index{|ending| filename.end_with?(ending)} # skip current and up directories
  return if skipped_endings && skipped_endings.index{|ending| filename.end_with?(ending)}

  pathed_source_file = "#{path}/#{filename}"
  if File.directory?(pathed_source_file)
    return if filename.start_with?('_')
    filename = 'css' if filename == 'css'
    filename = 'js' if filename == 'js'
    Dir.entries(pathed_source_file).each{|child_filename| recursiveFilteredCopy(pathed_source_file, child_filename, "#{dest}/#{filename}", skipped_endings)}
  else
    `cd #{PROJECT_ROOT}; mkdir -p #{dest}` if !File.exists?(dest)
    `cd #{PROJECT_ROOT}; cp #{pathed_source_file} #{dest}/`
  end
end

def recursiveHTMLToEscapedText(path, filename, dest)
  return if ['.', '..'].index{|ending| filename.end_with?(ending)} # skip current and up directories

  pathed_source_file = "#{path}/#{filename}"
  if File.directory?(pathed_source_file)
    return if filename.start_with?('_')
    filename = 'css' if filename == 'css'
    filename = 'js' if filename == 'js'
    Dir.entries(pathed_source_file).each{|child_filename| recursiveHTMLToEscapedText(pathed_source_file, child_filename, "#{dest}/#{filename}")}
  else
    extension = File.extname(pathed_source_file).downcase
    return if (extension != '.html') and (extension != '.coffee') and (extension != '.js')   # only .html, .coffee, .js files

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
  Dir.entries(root).each{|filename| recursiveFilteredCopy(root, filename, public_target, ['.styl', '.coffee', '.html', '.txt', '.pug'])}
  Dir.entries(root).each{|filename| recursiveHTMLToEscapedText(root, filename, root)}
end

####################################################
# The Vendor Folder
####################################################
`cd #{PROJECT_ROOT}; mkdir public/vendor` if !File.exists?('public/vendor')
`cd #{PROJECT_ROOT}; mkdir public/vendor/bootstrap` if !File.exists?('public/vendor/bootstrap')
Dir.entries(VENDOR_ROOT).each{|filename| recursiveFilteredCopy(VENDOR_ROOT, filename, 'public/vendor', ['.styl', '.coffee'])}

####################################################
# The Web Site
####################################################
`cd #{PROJECT_ROOT}; mkdir public/css` if !File.exists?('public/css')
`cd #{PROJECT_ROOT}; node_modules/.bin/stylus --use nib --out public/css app/assets/css &`

`cd #{PROJECT_ROOT}; mkdir public/js` if !File.exists?('public/js')
`cd #{PROJECT_ROOT}; node_modules/.bin/coffee --output public/js app/assets/js`

Dir.entries(ASSETS_ROOT).each{|filename| recursiveFilteredCopy(ASSETS_ROOT, filename, 'public', ['.styl', '.coffee'])}

setupDemo(TUTORIALS_ROOT, 'public/tutorials')
setupDemo(GETTING_STARTED_ROOT, 'public/getting_started')
setupDemo(SAMPLE_APPLICATIONS, 'public/sample_applications')

`cd #{PROJECT_ROOT}; node_modules/.bin/pug --pretty --out public/app app`
`find public/app/ -type f -name *.html -exec mv -i '{}' public/ ';'`
`rm -rf public/app`
