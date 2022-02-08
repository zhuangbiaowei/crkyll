require "liquid"

module Crkyll
    class Site
        getter   :source, :dest, :cache_dir, :config
        property :layouts, :posts, :pages, :static_files, :drafts, :inclusions, :sass, 
                      :exclude, :include, :includes, :lsi, :highlighter, :permalink_style,
                      :time, :future, :unpublished, :safe, :plugins, :limit_posts,
                      :show_drafts, :keep_files, :baseurl, :data, :file_read_opts,
                      :gems, :plugin_manager, :theme
    
        property :converters, :generators, :reader
        getter   :regenerator, :liquid_renderer, :includes_load_paths, :filter_cache, :profiler
        def self.init
            Site.new(load_config("./_config.yml"))
        end

        def initialize(config : YAML::Any)
            @config =  config
            @pages = Array(String).new
            Dir.glob("./**/*").each do |file|
                unless file.index("./_")
                    @pages << file if File.file?(file)
                end
            end
            @posts = Dir.glob("./_posts/**/*.md")
            @layouts = Dir.glob("./_layouts/**/*.html")
            @includes = Dir.glob("./_includes/**/*.html")
            @data = Dir.glob("./_data/**/*.yml")
            @sass = Dir.glob("./_sass/**/*.scss")
        end

        def parse_props(text)
            props = {} of String => String
            a = text.index("---\n")
            if a
                b = text.index("---\n", a+1)
            else
                return props
            end

            props_text = text[a.to_s.to_i+4..b.to_s.to_i-2]
            
            props_text.split("\n").each do |line|
                a,b=line.split(":")
                b=b.strip    
                if b[0]=='"' && b[-1]=='"'
                    b = b[1..-2]
                end
                props[a]=b
            end
            return props
        end

        def parse_page(file)
            text = File.read(file)
            result = parse_props(text)
            unless result.empty?
                layout = result["layout"]       
                index = text.index("\n---\n")
                if index
                    content = text[index+5, text.size-1]
                end
                return layout, content
            end
            return nil,text
        end

        def load_layout(layout)
            @layouts.each do |file|
                if file == "./_layouts/#{layout}.html"
                    layout, content = parse_page(file)
                    if layout
                        return render_template(layout, content)
                    else
                        return content.to_s
                    end
                end
            end
            return ""
        end

        def render_template(layout, content)
            layout_tpl = Liquid::Template.parse load_layout(layout)
            ctx = Liquid::Context.new
            ctx.set "content", content
            result = layout_tpl.render ctx
            return result
        end

        def build
            @pages.each do|page|
                layout, content = parse_page(page)
                puts render_template(layout, content)
            end
        end
    end
end