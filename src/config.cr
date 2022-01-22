require "yaml"

def load_config(config_path)
    yaml = File.open(config_path) do |config|
        YAML.parse(config)
    end
end