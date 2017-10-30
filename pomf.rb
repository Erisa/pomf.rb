#!/usr/bin/env ruby
# Author: Erisa Komuro (Seriel), forked from Euank's repo
# License: Public Domain


require 'tempfile'
require 'json'
require 'net/http'
require 'net/https'
use_curl = false
begin
  require 'net/http/post/multipart'
rescue LoadError
  use_curl = true
end

module Pomf
  def self.upload_file(filepath, upload = 'https://pomf.cat/upload.php', result = 'https://a.pomf.cat/')
    mime = nil
    file = File.new(filepath)
    url = URI.parse(upload)
    res = nil
    File.open(file.path) do |toup|
      req = Net::HTTP::Post::Multipart.new url.path,
        "files[]" => UploadIO.new(toup, mime, File.basename(toup.path))
      res = Net::HTTP.start(url.host,url.port, :use_ssl => url.scheme == 'https') do |http|
        http.request(req)
      end
      res = res.body rescue res
    end
    
    begin
      res = JSON.parse(res)
    rescue
      puts "Unable to parse json response: Got response #{res}"
      exit
    end
    
    if res["success"]
      return "#{res["files"].first["url"]}"
    else
      raise "Error: " + res["error"] || res.to_s
    end
  end
end
