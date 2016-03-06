#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

basepath = 'https://www.ccel.org/creeds/bcf/'
main_page = 'bcf.htm'

page = Nokogiri::HTML(open("#{basepath}#{main_page}"))

links = page.css('a[href*="bcfc"]')

links.each do |link|
  url = "#{basepath}#{link['href']}"
  puts url

  page = Nokogiri::HTML(open(url))
  chapter = page.css('a[name*="chapter"]').attr('name').to_s.gsub('chapter', '')

  title = page.css('h1,h2').text.gsub('.', '')

  puts "chapter: #{chapter}"
  puts "title: #{title}"
  puts ""
  # exit
end
