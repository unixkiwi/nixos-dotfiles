{ inputs, ... }:
{
  programs.git = {
    enable = true;
    config = {
      credential.helper = "store";
    };
  };
}
