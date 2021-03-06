require 'network_drawer'
require 'thor'

module NetworkDrawer
  # Cli for NetworkDrawer
  class Cli < Thor
    desc 'draw SOURCE', 'draw network diagram with SOURCE file'
    option(:style, aliases: :s,
                   banner: 'STYLE_FILE_IN_JSON')
    option(:layout, aliases: :l,
                    banner: 'GRAPHVIZ LAYOUT such as dot fdp ..')
    option(:format, aliases: :f,
                    banner: 'OUTPUT_FILE_FORMAT such as svg, png',
                    default: :svg)
    def draw(source_file)
      src = Source.read(source_file)
      op = {}
      op = { style: Source.read(options[:style]) } if options[:style]
      op.merge!(layout: options[:layout])
      op.merge!(format: options[:format])
      dest_file = source_file.gsub(File.extname(source_file), '')
      Diagram.draw(src, dest_file, op)
    end
  end
end
