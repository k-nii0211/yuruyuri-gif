require 'open-uri'
require 'nokogiri'
require 'fileutils'

local_dir = "#{File.dirname(__FILE__)}/../tmp"

FileUtils.mkdir_p(local_dir) unless File.exist?(local_dir)

%w(
http://blog.livedoor.jp/netagazou_okiba/archives/7499610.html
http://blog.livedoor.jp/netagazou_okiba/archives/7499582.html
).each do |url|
  doc = Nokogiri::HTML(open(url))
  doc.xpath('//div[@class="maincontents"]//img[@class="pict"]/@src').each do |node|
    img_content = open(node).read
    file_name = File.join(local_dir, File.basename(node))
    puts "Fetching #{node}"
    if File.exist?(file_name)
      puts "file was exists. #{file_name}"
      next
    end
    File.open(file_name, 'w') do |file|
      file.write(img_content)
    end
    puts "Success... #{file_name}"

    sleep 1
  end
end
