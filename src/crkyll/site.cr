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

        def build

        end
    end
end