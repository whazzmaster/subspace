#!/usr/bin/env ruby

require 'rubygems'
require 'commander'

require 'subspace'
require 'subspace/commands/base'
require 'subspace/commands/bootstrap'
require 'subspace/commands/configure'
require 'subspace/commands/init'
require 'subspace/commands/override'
require 'subspace/commands/provision'
require 'subspace/commands/ssh'
require 'subspace/commands/vars'

class Subspace::Cli
  include Commander::Methods
  # include whatever modules you need

  def run
    program :name, 'subspace'
    program :version, Subspace::VERSION
    program :description, 'Ansible-backed server provisioning tool for rails'

    command :init do |c|
      c.syntax = 'subspace init [options]'
      c.summary = ''
      c.description = ''
      c.example 'description', 'command example'
      c.when_called Subspace::Commands::Init
    end

    command :bootstrap do |c|
      c.syntax = 'subspace boostrap [host]'
      c.summary = 'Install ansible requirements (python) and authorized_keys file'
      c.description = 'Ansible has very few dependencies, but python is one that is not installed by
      default on many linux images.  The bootstrap command will install python on a host as well as
      copy the authorized_keys file.  You will possibly need to type a password here.'
      c.option '--password', "Ask for a password instead of using ssh keys"
      c.option '--yum', "Use yum instead of apt to install python"
      c.when_called Subspace::Commands::Bootstrap
    end

    command :provision do |c|
      c.syntax = 'subspace provision [options]'
      c.summary = ''
      c.description = ''
      c.example 'description', 'command example'
      c.when_called Subspace::Commands::Provision
    end

    command :ssh do |c|
      c.syntax = 'subspace ssh [options]'
      c.summary = 'ssh to the remote server as the administrative user'
      c.description = ''
      c.when_called Subspace::Commands::Ssh
    end

    command :configure do |c, args|
      c.syntax = 'subspace configure'
      c.summary = "Regenerate all of the ansible configuration files. You don't normally need to run this."
      c.description = ''
      c.when_called Subspace::Commands::Configure
    end

    command :override do |c, args|
      c.syntax = 'subspace override [role]'
      c.summary = 'Override a role configuration by copying the configuration locally'
      c.description = 'Copies the default role configuration to config/provision/<role> where it can be modified.'
      c.when_called Subspace::Commands::Override
    end

    command :vars do |c, args|
      c.syntax = 'subspace vars [environment]'
      c.summary = 'View or edit the encrypted variables for an environment'
      c.description = ''
      c.option '--edit', "Edit the variables instead of view"
      c.when_called Subspace::Commands::Vars
    end

    run!
  end
end

#MyApplication.new.run if $0 == __FILE__
