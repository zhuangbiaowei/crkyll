require "yaml"

def load_config(config_path)
    if File.exists?(config_path)
        yaml = File.open(config_path) do |config|
            YAML.parse(config)
        end
        return yaml
    else
        return YAML.parse("")
    end
end