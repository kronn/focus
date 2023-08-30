#!/usr/bin/env crystal

require "commander"

require "focus/setup"
setup = Focus::Setup.new
setup.create_missing_dirs

tasks = setup.tasks

# # TODO arbitrary subtasks as external executables
# # - [x] find commands
# # - [ ] define minimal requirements for commands
# #   - short-desc for help
# #   - ...
# # - [ ] add them as subcommands to commander
# possible_commands = ENV["PATH"].split(":").flat_map do |path|
#   Dir.glob("#{path}/focus-*")
# end

# task_config_yaml = xdg_dirs.config.read_file("tasks/mails.yaml")
# require "yaml"
# task_config = YAML.parse(task_config_yaml)
# puts task_config

cli = Commander::Command.new do |cmd|
  cmd.use = "focus"
  cmd.long = "Choose a task and stay focussed on it"

  cmd.run { puts cmd.help }
end

require "focus/commands/list"
cli.commands.add do |cmd|
  cmd.use = "list"
  cmd.short = "List available tasks"
  cmd.run { Focus::Commands::List.new(tasks, setup.config_dir).run }
end

cli.commands.add do |cmd|
  cmd.use = "start <task>"
  cmd.short = "Start focussing on one task"

  cmd.run do |options, arguments|
    puts arguments
    abort(cmd.help) unless tasks.includes?(arguments.first)
  end
end

Commander.run(cli, ARGV)
