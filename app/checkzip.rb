

def is_zip(num)
    if num == ""
      return false
    else
      line = []
      File.open("/Users/ben/Development/FI/mod1/project/ruby-project-guidelines-austin-web-012720/app/zipcodes.rtf",'r') do |f|

        line = f.readlines

      end
      array = []
      line.each do |lines|
        array << lines.gsub("\n", "")
      end

    end

    return array.include?(num)
end
