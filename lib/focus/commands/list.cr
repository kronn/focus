#!/usr/bin/env crystal

require "yaml"
require "xdg_base_directory"

module Focus
  module Commands
    class List
      @tasks : Array(String)
      @config_dir : XdgBaseDirectory::XdgDir

      def initialize(tasks, config_dir)
        @tasks = tasks
        @config_dir = config_dir
      end

      def run
        configs = @tasks.map do |fn|
          YAML.parse(@config_dir.read_file("tasks/#{fn}"))
        end

        cmds = configs.map { |config| config["command"] }
        col_size = cmds.reduce(0) { |memo, cmd| Math.max(cmd.to_s.size, memo) }

        configs.each do |config|
          puts "%#{col_size}s   %s" % [config["command"], config["name"]]
        end
      end
    end
  end
end
