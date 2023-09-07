{ config, lib, pkgs, ... }:

{
  # Kitty terminal
  # https://sw.kovidgoyal.net/kitty/conf.html
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.kitty.enable
  programs.kitty.enable = true;

  programs.kitty.settings = {
    # https://fsd.it/shop/fonts/pragmatapro/
    font_family = "JetBrainsMono Nerd Font Mono";
    font_size = "14.0";
    adjust_line_height = "140%";
    disable_ligatures = "cursor"; # disable ligatures when cursor is on them

    # Window layout
    hide_window_decorations = "titlebar-only";
    window_padding_width = "10";

    # Tab bar
    tab_bar_edge = "top";
    tab_bar_style = "powerline";
    tab_title_template = "Tab {index}: {title}";
    active_tab_font_style = "bold";
    inactive_tab_font_style = "normal";
    tab_activity_symbol = "";
  };

  # Change the style of italic font variants
  programs.kitty.extraConfig = ''
    font_features JetBrainsMono-Italic +ss06
    font_features JetBrainsMono-BoldItalic +ss07
    modify_font underline_thickness 400%
    modify_font underline_position 2
  '';

  programs.kitty.extras.useSymbolsFromNerdFont = "JetBrainsMono Nerd Font";

  programs.kitty.extras.colors = {
    enable = true;

    # Background dependent colors
    dark = config.colors.dracula.pkgThemes.kitty;
    light = config.colors.dracula.pkgThemes.kitty;
  };
}
