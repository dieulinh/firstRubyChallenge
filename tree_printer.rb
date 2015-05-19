LEAVES_MARKERS = '<leaves>'
def create_tree(path, tree)
  parts = path.split('/')
  if parts.length==1
    tree[LEAVES_MARKERS].push( parts[0])
  else
    node = parts[0]
    others = path[path.index('/')+1..path.length]

    if !tree.has_key? node
      tree[node] = {LEAVES_MARKERS => []}
      
    end
    create_tree(others, tree[node])
  end
end
def print_tree(tree, indent)

  tree.each do |k, v|
    if k == LEAVES_MARKERS
      if v
        s = '    '* indent
        v.each do |x|

          puts "#{s+ '|----'+x}"
        end

      end
    else

      s = '    '*(indent)
      puts s+k
      if v.is_a? Hash
        print_tree(v, indent+1)
      else
        s = '    '*(indent+1)
        put s + v
      end
    end

  end
end



filename = ARGV.first
if filename
  txt_file = File.new(filename, 'r')
  array = []
  while (line=txt_file.gets)
    # puts line
    line.strip!
    array.push(line)
  end

  rs_hash = Hash.new
  array.sort.each do |cr_path|
    # puts cr_path
    create_tree(cr_path, rs_hash)


  end
  print_tree(rs_hash, 1)
else
  puts "Invalid argument! Try again by passing the filename to make a tree"
  
end

# puts rs_hash




