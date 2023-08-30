#!/usr/bin/env crystal

require "xdg_base_directory"
# xdg_dirs.config.write_file("settings.ini.backup", setttings)

module Focus
  class Setup
    @tasks_dir : String

    def initialize
      @xdg_dirs  = XdgBaseDirectory::XdgDirs.new("focus")
      @tasks_dir = @xdg_dirs.config.file_path("tasks")
    end

    def config_dir
      @xdg_dirs.config
    end

    def create_missing_dirs
      Dir.mkdir_p(@tasks_dir) unless Dir.exists?(@tasks_dir)
    end

    def tasks
      @tasks ||= Dir.new(@tasks_dir).children
    end
  end
end
