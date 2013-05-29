require 'digest'
require "fileutils"

class Item

  def self.get sha
    "/uploads/#{sha}"
  end

  def self.create file
    sha = Digest::SHA1.file(file.tempfile).hexdigest
    path = "/uploads/#{sha}.#{file[:type].split('/').last}"
    FileUtils.move file.tempfile.path, ".#{path}"
    path
  end

  def self.delete sha
    FileUtils.delete "./uploads/#{sha}"
  end

end