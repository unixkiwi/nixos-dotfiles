{ pkgs, config, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dart-code.flutter
      christian-kohler.path-intellisense
    ];
    userSettings = {
      "editor.fontFamily" = "'${config.stylix.fonts.monospace.name}'";
      "editor.fontSize" = config.stylix.fonts.sizes.applications;
    };
  };
}
