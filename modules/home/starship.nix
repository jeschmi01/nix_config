{ ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = "$os$directory$git_branch$character ";

      os = {
        disabled = false;
        style = "bg:#cfe5e8 fg:#223d9d";
        symbols = {
          NixOS = " ";
        };
        format = "[ $symbol]($style)[](fg:#cfe5e8 bg:#2753f8)";
      };

      directory = {
        style = "bg:#2753f8 fg:#ffffff";
        format = "[ $path ]($style)[](fg:#2753f8 bg:cyan)";
        truncation_length = 3;
      };

      git_branch = {
        symbol = " ";
        style = "bg:cyan fg:#29210a";
        format = "[ $symbol$branch ]($style)";
      };

      character = {
        format = "[](fg:cyan)";
      };

      add_newline = false;
    };
  };
}
