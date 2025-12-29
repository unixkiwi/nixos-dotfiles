{ inputs, ... }:
{
  # Keymap in X11
  services.xserver.xkb = {
    layout = "de";
    options = "caps:swapescape";
  };

  # Console keymap
  console.keyMap = "de-latin1";
}
