{ pkgs, ... }:
{
  programs.nvf = {
    defaultEditor = true;
    enable = true;
    enableManpages = true;
    settings = {
      vim = {
        options = {
          tabstop = 2;
          shiftwidth = 2;
        };

        theme = {
          enable = true;
          name = "tokyonight";
          style = "night";
        };

        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          highlight-undo.enable = true;
          indent-blankline.enable = true;
        };

        tabline.nvimBufferline.enable = true;

        viAlias = true;
        vimAlias = true;

        statusline.lualine.enable = true;
        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
        };

        autopairs.nvim-autopairs.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope = {
          enable = true;
          mappings = {
            findFiles = "<leader><leader>";
            liveGrep = "<leader>ff";
          };
        };

        comments.comment-nvim = {
          enable = true;
          mappings = {
            toggleCurrentLine = "<leader>cc";
            toggleSelectedBlock = "<leader>cb";
          };
        };
        dashboard.alpha.enable = true;
        diagnostics.enable = true;
        filetree.neo-tree.enable = true;
        formatter.conform-nvim.enable = true;

        notify.nvim-notify.enable = true;

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        git = {
          enable = true;
          git-conflict.enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
          neogit.enable = true;
        };

        treesitter = {
          enable = true;
          context.enable = true;
          indent.enable = true;
        };

        languages = {
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableTreesitter = true;

          dart = {
            enable = true;
            flutter-tools.enable = true;
          };
          nix = {
            enable = true;
            treesitter.enable = true;
            format = {
              enable = true;
              type = [ "nixfmt" ];
            };
            lsp = {
              enable = true;
              servers = [ "nixd" ];
            };
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          smartcolumn.enable = true;
        };

        lineNumberMode = "relNumber";

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lightbulb.enable = true;
          lspconfig.enable = true;
          lspkind.enable = true;
          mappings = {
            codeAction = "<leader>ca";
            format = "<leader>cf";
            renameSymbol = "<leader>cr";
          };
          servers.nixd = {
            enable = true;
            options = {
              nixpkgs = {
                expr = "import <nixpkgs> { }";
                formatting = {
                  command = [ "nixfmt" ];
                };
                nixos = {
                  expr = "(builtins.getFlake \"/home/kiwi/nixos-dotfiles\").nixosConfigurations.laptop.options";
                };
                home-manager = {
                  expr = "(builtins.getFlake \"/home/kiwi/nixos-dotfiles\").nixosConfigurations.laptop.options.home-manager.users.type.getSubOptions []";
                };
              };
            };
          };
        };
      };
    };
  };
}
