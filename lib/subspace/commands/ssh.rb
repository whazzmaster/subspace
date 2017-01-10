class Subspace::Commands::Ssh < Subspace::Commands::Base
  def initialize(args, options)
    @host = args.first
    run
  end

  def run
    ansible_command "ansible", @host, '-a', "/bin/bash -l"
  end

  private

  def update_ansible_cfg
    template "ansible.cfg"
  end

end