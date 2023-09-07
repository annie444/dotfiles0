# Palette       HEX       RGB           HSL           ANSI!16   ANSI256
# ------        ----      ----          ----          -------   -------
# Background	  #282a36	  40  42  54    231 15  18    30        59
# Current Line	#44475a	  68  71  90    232 14  31    30        60
# Foreground	  #f8f8f2	  248 248 242   60  30  96    97        231
# Comment	      #6272a4	  98  114 164   225 27  51    34        103
# Cyan	        #8be9fd	  139 233 253   191 97  77    97        159
# Green	        #50fa7b	  80  250 123   135 94  65    92        120
# Orange	      #ffb86c	  255 184 108   31  100 71    93        222
# Pink	        #ff79c6	  255 121 198   326 100 74    95        212
# Purple	      #bd93f9	  189 147 249   265 89  78    97        183
# Red	          #ff5555	  255 85  85    0   100 67    91        210
# Yellow	      #f1fa8c   241 250 140   65  92  76    97        229


{ config, ... }:

{
  colors.dracula = {
    colors = {
      color0 = "#282a36";
      color1 = "#44475a";
      color2 = "#f8f8f2";
      color3 = "#6272a4";
      color4 = "#8be9fd";
      color5 = "#50fa7b";
      color6 = "#ffb86c";
      color7 = "#ff79c6";
      color8 = "#bd93f9";
      color9 = "#ff5555";
      color10 = "#f1fa8c";
    };

    namedColors = {
      # Solarized names
      background = "color0";
      currentLine = "color1";
      foreground = "color2";
      comment = "color3";
      yellow = "color10";
      red = "color9";
      pink = "color7";
      purple = "color8";
      cyan = "color4";
      green = "color5";
      orange = "color6";
    };

    terminal = {
      bg = "background";
      fg = "foreground";
      cursorBg = "currentLine";
      cursorFg = "foreground";
      selectionBg = "comment";
      selectionFg = "foreground";
    };

    pkgThemes.kitty = {
      url_color = "cyan";
      tab_bar_background = "comment";
      active_tab_background = "green";
      active_tab_foreground = "background";
      inactive_tab_background = "currentLine";
      inactive_tab_foreground = "foreground";
    };
  };
}
