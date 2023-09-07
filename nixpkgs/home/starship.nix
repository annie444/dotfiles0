{
  # Starship Prompt
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.starship.enable
  programs.starship.enable = true;

  programs.starship.settings = {
    # See docs here: https://starship.rs/config/
    # Symbols config configured ./starship-symbols.nix.
    right_format = "$username$hostname$localip$battery$memory_usage [─╯](dimmed white)";
    format = "[╭─](dimmed white) $os$shell$directory$vcsh$fossil_branch$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$dotnet$golang$java$nodejs$php$rust$conda $fill $cmd_duration$sudo$jobs$status$shlvl$singularity$kubernetes$pijul_channel$docker_context$package$c$cmake$cobol$daml$dart$deno$elixir$elm$erlang$fennel$guix_shell$haskell$haxe$helm$julia$kotlin$gradle$lua$nim$ocaml$opa$perl$pulumi$purescript$python$raku$rlang$red$ruby$scala$solidity$swift$terraform$vlang$vagrant$zig$buf$nix_shell$meson$spack$aws$gcloud$openstack$azure$env_var$crystal$container$shell$time [─╮](dimmed white)
[╰─](dimmed white) $character";
    fill = {
      symbol = "•";
      style = "dimmed white";
    };
    continuation_prompt = "❯";
    character.success_symbol = "[❯](bold green) ";
    character.error_symbol = "[✗](bold red) ";
    add_newline = true;
    directory.fish_style_pwd_dir_length = 1; # turn on fish directory truncation
    directory.truncation_length = 2; # number of directories not to truncate
    hostname.style = "bold green"; # don't like the default
    shlvl.disabled = false;
    username.style_user = "bold blue"; # don't like the default
  };
}
