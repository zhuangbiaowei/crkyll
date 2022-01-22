module Crkyll
    class Site
        getter   :source, :dest, :cache_dir, :config
        property :layouts, :pages, :static_files, :drafts, :inclusions,
                      :exclude, :include, :lsi, :highlighter, :permalink_style,
                      :time, :future, :unpublished, :safe, :plugins, :limit_posts,
                      :show_drafts, :keep_files, :baseurl, :data, :file_read_opts,
                      :gems, :plugin_manager, :theme
    
        property :converters, :generators, :reader
        getter   :regenerator, :liquid_renderer, :includes_load_paths, :filter_cache, :profiler
    end
end