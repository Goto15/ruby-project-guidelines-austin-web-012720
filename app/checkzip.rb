def is_zip(num)
    if num == ""
      return false
    else
      line = []
      File.open("./app/zipcodes.rtf",'r') do |f|

        line = f.readlines

      end
      array = []
      line.each do |lines|
        array << lines.gsub("\n", "")
      end

    end

    return array.include?(num)
end
