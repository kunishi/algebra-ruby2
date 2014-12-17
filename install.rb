#!/usr/bin/env ruby
# install command
# Ver. 1.1 (2004.03.08)

require 'rbconfig'
require 'getoptlong'
require 'ftools'

project = (File.split(Dir.getwd)).last.sub(/-((?:\d+\.)*\d+)\z/, "")
version = File.file?("VERSION") ? open("VERSION"){|f| f.read}.strip : $1

libname = project# + "-" + version
libdir = "lib"
mandir, manjadir = "doc", "doc-ja"
logfile = "InstalledFiles"

destdir = Config::CONFIG["sitelibdir"]
destmandir = File.join(Config::CONFIG["prefix"], "doc", "ruby", libname, "doc")
destmanjadir = File.join(Config::CONFIG["prefix"], "doc", "ruby", libname, "doc-ja")

instman = false
noharm = false

uninstall = false

Usage = "\
  Usage: ruby install.rb [options]
  
      option      argument      action
      ------      --------      ------
      --destdir   dir           Destination dir
      -d                        (default is #{destdir})
      
      --mandir    dir[,dir-ja]  Manual dir
                                (default is #{destmandir},#{destmanjadir})
      
      --man                     Install manuals

      --uninstall               UnInstall

      --help                    Print this help
      -h
      
      --noharm                  Do not install, just print commands
      -n
"

opts = GetoptLong.new(
  [ "--destdir",   "-d",            GetoptLong::REQUIRED_ARGUMENT ],
  [ "--mandir",                     GetoptLong::REQUIRED_ARGUMENT ],
  [ "--man",       "-m",            GetoptLong::NO_ARGUMENT       ],
  [ "--uninstall",                  GetoptLong::NO_ARGUMENT       ],
  [ "--help",      "-h",            GetoptLong::NO_ARGUMENT       ],
  [ "--noharm",    "-n",            GetoptLong::NO_ARGUMENT       ]
)

opts.each do |opt, arg|
  case opt
  when '--destdir', '-d'
    destdir = arg
  when '--man', '-m'
    instman = true
  when '--mantdir'
    destmandir, destmanjadir = arg.split(/,/)
  when '--help', '-h'
    print Usage, "\n"
    exit
  when '--noharm', '-n'
    noharm = true
  when '--uninstall'
    uninstall = true
  else
    raise "unrecognized option: ", opt
  end
end

raise ArgumentError,
  "unrecognized arguments #{ARGV.join(' ')}" unless ARGV == []

files = []

def collect_files(fspec, destdir, files)
  fspec = fspec.sub(/\/$/, '') #/
  if FileTest.directory? fspec
    Dir.foreach(fspec) do |f|
      next if f == "."|| f == ".."
      fspec0 = File.join(fspec, f)
      destdir0 = File.join(destdir, f)
      collect_files(fspec0, destdir0, files)
    end
  else
    files.push [fspec, destdir]
  end
end

if instman
  collect_files(mandir, destmandir, files)
  collect_files(manjadir, destmanjadir, files) if destmanjadir
else
  collect_files(libdir, destdir, files)
end
#Dir.glob(libdir + "/**/*").each do |file|
#  tfile = File.join(destdir, File.basename(file))
#  files.push [file, tfile]
#end

log = open(logfile, "a") unless noharm || uninstall
dirs = {}
for src, dest in files
  d = File.dirname(dest)
  if !dirs[d] && !File.directory?(d)
    puts "File.makedir #{d}" unless uninstall
    File.makedirs(d) unless noharm || uninstall
    dirs[d] = true
  end

  if uninstall
    if File.file?(dest)
      puts "File.unlink #{dest}"
      File.unlink(dest) unless noharm
    end
  else
    puts "File.install #{src}, #{dest}, 0644"
    File.install(src, dest, 0644, false) unless noharm
    log.puts dest unless noharm
  end
end
log.close unless noharm || uninstall
