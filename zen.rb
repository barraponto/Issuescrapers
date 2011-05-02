require 'nokogiri' 
require 'open-uri'

queue = Nokogiri::HTML(open('http://drupal.org/project/issues/zen'))
issues = Hash.new

queue.css('.view-id-project_issue_project tbody tr').each do |line|
  issue = Hash.new
  url = line.at_css('a').attr('href')

  issue = {
    :url => url,
    :title => line.at_css('a').content.strip,
    :status => line.at_css('.views-field-sid').content.strip,
    :priority => line.at_css('.views-field-priority').content.strip
  }

  id = url[6..url.size].to_i

  issues[id] = issue
end

puts issues.first.to_s
