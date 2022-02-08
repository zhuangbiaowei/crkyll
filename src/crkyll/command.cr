require "admiral"
require "kemal"

module Crkyll
    class Command < Admiral::Command
      define_help description: "Crkyll 0.5.0 -- Crkyll is a blog-aware, static site generator in Crystal."
    
      class Compose < Admiral::Command
        def run
          puts "Compose"
        end
      end
    
      class Docs < Admiral::Command
        def run
          puts "Docs"
        end
      end
    
      class Import < Admiral::Command
        def run
          puts "Import"
        end
      end
    
      class Build < Admiral::Command
        def run
          puts "Build"
          site = Crkyll::Site.init
          site.build
        end
      end
    
      class Clean < Admiral::Command
        def run
          puts "Clean"
        end
      end
    
      class Doctor < Admiral::Command
        def run
          puts "Doctor"
        end
      end
    
      class New < Admiral::Command
        def run
          puts "New"
        end
      end
    
      class NewTheme < Admiral::Command
        def run
          puts "NewTheme"
        end
      end
    
      class Server < Admiral::Command
        def run
          puts "Start Web Server"
          get "/" do |env|
            env.redirect "/index.html"
          end
          Kemal.config.public_folder = "./_site"
          Kemal.run
        end
      end
    
      register_sub_command :compose, Compose
      register_sub_command :docs, Docs
      register_sub_command :import, Import
      register_sub_command :build, Build, description: "Build your site", short: "b"
      register_sub_command :clean, Clean, description: "Clean the site (removes site output and metadata file) without building."
      register_sub_command :doctor, Doctor, description: "Search site and print specific deprecation warnings", short: "hyde"
      register_sub_command :new, New, description: "Creates a new Crkyll site scaffold in PATH"
      register_sub_command "new-theme", NewTheme, description: "Creates a new Crkyll theme scaffold"
      register_sub_command :server, Server,description: "Serve your site locally", short: "s"
    
      def run
        puts help
      end
    end
  end