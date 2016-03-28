#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'yaml'

$books = "Genesis
Exodus
Leviticus
Numbers
Deuteronomy
Joshua
Judges
Ruth
1 Samuel
2 Samuel
1 Kings
2 Kings
1 Chronicles
2 Chronicles
Ezra
Nehemiah
Esther
Job
Psalms
Proverbs
Ecclesiastes
Song of Solomon
Isaiah
Jeremiah
Lamentations
Ezekiel
Daniel
Hosea
Joel
Amos
Obadiah
Jonah
Micah
Nahum
Habakkuk
Zephaniah
Haggai
Zechariah
Malachi
Matthew
Mark
Luke
John
Acts
Romans
1 Corinthians
2 Corinthians
Galatians
Ephesians
Philippians
Colossians
1 Thessalonians
2 Thessalonians
1 Timothy
2 Timothy
Titus
Philemon
Hebrews
James
1 Peter
2 Peter
1 John
2 John
3 John
Jude
Revelation
".split("\n")

$manual = {
  "Job, 22.2,3." => "Job 22:2, 3;",
  "Ezk. 36.26." => "Ezekiel 36:26;",
  "Cant. 5.2,3.6." => "??? Cant. 5.2,3.6. ???",
  "Col: 2.20 22,23:" => "Colossians 2:20, 22, 23;",
  "2 Cro. 6 22,23." => "2 Corinthians 6:22, 23;",
  "Rom, 6.2,4." => "Romans 6:2, 4;",
  "2 Cor: 6,14,15." => "2 Corinthians 6:14, 15;",
  "Rom, 9.22,23." => "Romans 9:22, 23;"
}

def cleanup_verses(verses)
  # puts verses

  if $manual[verses]
    return $manual[verses]
  end

  actual_verses = {}
  verses = verses.split('.')
  book = nil
  chapter = nil

  verses.map!(&:strip)

  verses.map! do |v|
    res = v

    if v.match(/[a-zA-Z]+/)
      matches = $books.grep(/^#{v}/)
      if !matches.empty?
        res = matches.first.gsub(' ', '_')
      end
    end
    res
  end

  verses.map! do |v|
    v.split(' ')
  end

  verses.flatten!

  # puts verses.inspect

  verses.each_with_index do |v, i|
    # printf "v: %-10s i: %-10s" % [v, i]
    if v.match(/[a-zA-Z]+/)
      matches = $books.grep(/^#{v.gsub('_', ' ')}/)
      if !matches.empty?
        # print "a: book"
        book = matches.first
        chapter = nil
        actual_verses[book] = {}
      else
        # print "a: letters"
      end
    elsif chapter
      # matches = $books.grep(/^#{v} #{verses[i+1]}/)
      # if !matches.empty?
      #   print "a: book (numbered)"
      #   book = matches.first
      #   chapter = nil
      #   actual_verses[book] = {}
      # else
        # print "a: verses"
        actual_verses[book][chapter] = v.split(',')
      # end
    elsif book
      # print "a: chapter"
      chapter = v
      actual_verses[book][chapter] = []
    else
      verses[i+1] = "#{v} #{verses[i+1]}"
      # print "a: else"
    end
    # puts ""
  end

  # puts actual_verses.inspect

  verses_string = ""

  actual_verses.each do |book, chapters|
    verses_string += "#{book} "
    chapters.each do |chapter, verses|
      verses_string += "#{chapter}:#{verses.join(', ')}; "
    end
    verses_string.rstrip!
    verses_string += " "
  end

  verses_string.strip!

  # puts verses_string
  verses_string
end

# cleanup_verses "2 Pet. 1. 19,20,21. 2 Tim. 3. 16. 2 Thes. 2. 13. 1 Joh. 5. 9."
# exit

lbcf = {}

basepath = 'https://www.ccel.org/creeds/bcf/'
main_page = 'bcf.htm'

page = Nokogiri::HTML(open("#{basepath}#{main_page}"))

links = page.css('a[href*="bcfc"]')

links.each do |link|
  url = "#{basepath}#{link['href']}"
  page = Nokogiri::HTML(open(url))

  chapter = page.css('a[name*="chapter"]').attr('name').to_s.gsub('chapter', '')
  title = page.css('h1,h2').text.gsub('.', '').gsub("\r\n", ' ')

  lbcf[chapter] = {title: title, paragraphs: {}}

  page.css("a[name*='c#{chapter}']").each do |node|
    paragraph = node.attr('name').gsub("c#{chapter}.", '')
    content = node.parent

    lbcf[chapter][:paragraphs][paragraph] = []

    references = content.css('a[href*="scric"]')

    content.children.each_with_index do |child, index|

      if child.element? && child.css('a').any? && child.css('a').attr('href')


        ref_url = child.css('a').attr('href')
        ref_verses = page.css("a[href='#{ref_url}']").last

        ref_verses.css('i').remove
        verses = ref_verses.text.to_s.gsub("\r\n", ' ').strip
        verses = cleanup_verses(verses)

        lbcf[chapter][:paragraphs][paragraph][index - 1] = "<span class=\"ref\" data-verses=\"#{verses}\">#{lbcf[chapter][:paragraphs][paragraph][index - 1]}"
        child = "</span>"

      elsif child.text?
        child = child.text.to_s.gsub("#{paragraph}.", '')
      elsif child.text
        child = child.text
      end

      lbcf[chapter][:paragraphs][paragraph] << child.to_s.gsub("\r\n", ' ')
    end
  end
end

puts <<-EOS
<html>
<head>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<script src="/annotate.js"></script>
	<link href='https://fonts.googleapis.com/css?family=Martel:300' rel='stylesheet' type='text/css'>
	<link href='/style.css' rel='stylesheet' type='text/css'>
</head>
<body>
	<div class="main">
		<h1>London Baptist Confession of Faith (1689)</h1>
EOS

lbcf.each do |chapter, content|
  puts "\t\t<section>"
  puts "\t\t\t<h3 id=\"chapter-#{chapter}\">Chapter #{chapter}</h3>"
  puts "\t\t\t<h2>#{content[:title]}</h2>"
  content[:paragraphs].each do |p_number, p_contents|
    puts "\t\t\t<p>"
    puts "\t\t\t\t<span class=\"paragraph-number\">#{p_number}.</span>"
    puts "\t\t\t\t#{p_contents.join.strip.gsub('&', '&amp;')}"
    puts "\t\t\t</p>"
  end
  puts "\t\t</section>"
end

puts <<-EOS
	</div>

	<div class="side">
		lots of stuff goes here
	</div>
</body>
</html>
EOS
