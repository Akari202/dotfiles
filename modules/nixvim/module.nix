{
  pkgs,
  lib,
  options,
  config,
  ...
}: let
  helpers = lib.nixvim;
in {
  imports = [
    ./config/format.nix
    ./config/keybinds.nix
    ./config/lsp.nix
    ./config/plugins.nix
    ./config/completion.nix
  ];

  options.akari = {
    rust.enable = lib.mkEnableOption "enable rust tools";
    extraTools.enable = lib.mkEnableOption "enable extra tools";
  };

  config = {
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      sops
    ];

    globals = {
      mapleader = "'";
      maplocalleader = "\\";
    };

    opts = {
      number = true;
      relativenumber = true;

      expandtab = true;
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      autoindent = true;
      smartindent = true;

      fixendofline = true;
      fileencoding = "utf-8";
      encoding = "utf-8";
      backup = false;
      writebackup = false;
      updatetime = 500;

      wrap = true;
      whichwrap = "b,s,<,>,[,]";

      ignorecase = true;
      hlsearch = true;

      termguicolors = true;
      background = "light";

      concealcursor = "";
      conceallevel = 0;
    };

    autoCmd = [
      {
        event = ["FileType"];
        pattern = ["nix"];
        callback = {
          __raw = ''
            function()
              vim.opt_local.tabstop = 2
              vim.opt_local.shiftwidth = 2
              vim.opt_local.softtabstop = 2
            end
          '';
        };
      }
    ];

    userCommands = {
      FormatDisable = {
        desc = "Disable autoformat on save";
        bang = true;
        command.__raw = ''
          function(args)
            if args.bang then
              vim.b.disable_autoformat = true
            else
              vim.g.disable_autoformat = true
            end
          end
        '';
      };

      FormatEnable = {
        desc = "Re-enable autoformat on save";
        command.__raw = ''
          function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
          end
        '';
      };
    };

    colorschemes.one.enable = true;
  };
}
