require "highline/import"

year = ask "Year?"
day = ask "Day?"
dir = "#{year}/day_#{day}"

system "mkdir #{dir}"
system "touch #{dir}/README.md #{dir}/day_#{day}.rb #{dir}/day_#{day}_data.txt"
