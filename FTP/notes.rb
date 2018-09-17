
work = Collection.last.works[1]
thompson_pages = {}
 work.pages[3..575].each_with_index {|pg,i| words=pg.source_text.scan(/([A-Z]{2,})/).each {|cap| thompson_pages[cap.first] ||= i+4 } unless  pg.source_text.blank? }
 alcedo_text = File.read('/home/benwbrum/dev/clients/delrio/alcedo/mine/Alcedo/FTP/alcedo-1.txt');0
alcedo_lines = alcedo_text.split("\n");0

current_page = 3
paginated = {}
alcedo_lines.each_with_index do |line,i|
  if line.match /([A-Z]{2,})/
    headword = $1
    tentative_page = thompson_pages[headword]
#    print "#{i}\tthompson_pages[#{headword}] => #{thompson_pages[headword]}\n"
    if tentative_page && headword.match(/^[A-C]/)
      print "#{i}\t#{headword}\t#{tentative_page}\t#{(tentative_page.to_i - current_page.to_i)}\n"
      if (tentative_page.to_i - current_page.to_i) < 4
        print "#{i}\tcurrent_page #{current_page} -> #{tentative_page}\n"
        current_page = tentative_page
      end
    end
  end
  paginated[current_page] ||= []
#  print "#{i}\tadding to page #{current_page}\t(size=#{paginated[current_page].size})\n"
  paginated[current_page] << line
end;0

paginated.keys.each do |page_no|
  filename = page_no.to_s.rjust(3,"0") + ".txt"
  outfile = File.join('/home/benwbrum/dev/clients/delrio/alcedo/mine/Alcedo/FTP/v1', filename)
  File.write(outfile, paginated[page_no].join("\n"))
end


#TODO: figure out what's wrong with these files
#  004.txt 018.txt 022.txt 042.txt 

