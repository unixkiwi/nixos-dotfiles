{ inputs, pkgs, ... }:
{
  imports = [
    ./android.nix
    ./git.nix
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dart-code.flutter
      christian-kohler.path-intellisense
    ];
  };
}
