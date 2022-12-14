# frozen_string_literal: true

# this does not work for puzzle input. is working for example input
def get_size(directories, current_size = 0)
  directories.each_key do |key|
    next unless directories[key].is_a?(Hash)

    l_size = directories[key]["size"]
    current_size += l_size unless current_size + l_size > 100_000
    get_size(directories[key], current_size) if directories[key].keys.count > 2
  end
  p current_size
end

INPUT = "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k"

data = INPUT.each_line.map(&:chomp)
directories = {}
current_dir = directories
current_parents = []
data.each do |line|
  if line.start_with? "$"
    dir = line.match(/\$\scd\s(.+)/)
    if dir
      if dir[1] == ".."
        current_parents.pop
        current_parents.each_with_index do |ldir, i|
          current_dir = i.zero? ? directories[ldir] : current_dir[ldir]
        end
      else
        current_parents.push(dir[1])
        current_dir[dir[1]] = {} unless current_dir[dir[1]]
        current_dir = current_dir[dir[1]]
        next
      end
    end
  elsif line.start_with? "dir"
    dir = line.match(/dir\s(.+)/)
    current_dir[dir[1]] = {}
  else
    matches = line.match(/(\d+)\s(.+)/)
    size = matches[1].to_i
    file = matches[2]
    if current_dir["files"]
      current_dir["files"].push({ name: file, size: size })
    else
      current_dir["files"] = [{ name: file, size: size }]
    end
    local_dir = nil
    current_parents.each_with_index do |ldir, i|
      local_dir = i.zero? ? directories[ldir] : local_dir[ldir]
      if local_dir["size"]
        local_dir["size"] += size
      else
        local_dir["size"] = size
      end
    end
  end
end

p directories
get_size(directories)
