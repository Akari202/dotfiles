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
    ./config/completion.nix
  ];

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

  plugins = {
    marks.enable = true;
    gitsigns.enable = true;
    web-devicons.enable = true;
    visual-whitespace.enable = true;
    treesitter-context.enable = true;
    tiny-inline-diagnostic.enable = true;
    friendly-snippets.enable = true;
    substitute.enable = true;
    kitty-navigator.enable = true;
    parinfer-rust.enable = true;

    colorizer = {
      enable = true;
      settings = {
        filetypes = ["*"];
        user_default_options = {
          names = false;
        };
      };
    };

    mini-surround = {
      enable = true;
      settings = {
        mappings = {
          add = "ys";
          delete = "ds";
          find = "gs";
          find_left = "gS";
          highlight = "";
          replace = "cs";
        };
      };
    };

    lualine = {
      enable = true;
      settings = {
        options.theme = "onelight";
        tabline = {
          lualine_a = [
            {
              __unkeyed-1 = "buffers";
              mode = 2;
              max_length = 0;
              buffers_color = {
                inactive = {
                  fg = "#2a2b33";
                  bg = "#d0d0d0";
                };
                active = {
                  fg = "#f8f8f8";
                  bg = "#3e953a";
                };
              };
            }
          ];
          lualine_z = ["tabs"];
        };
      };
    };
    treesitter = {
      enable = true;
      nixvimInjections = true;
      settings = {
        ensure_installed = [
          "c"
          "lua"
          "markdown"
          "markdown_inline"
          "rust"
          "python"
          "html"
          "json"
          "toml"
          "typst"
          "nix"
          "fortran"
        ];
      };
    };
    rustaceanvim = {
      enable = true;
      settings = {
        server = {
          on_attach = helpers.mkRaw ''
            function(client, buf)
              local opts = { silent = true, buffer = buf }
              vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, opts)
              vim.keymap.set("n", "<leader>a", function() vim.cmd.RustLsp("codeAction") end, opts)
            end
          '';
          default_settings = {
            rust-analyzer = {
              cargo.allFeatures = true;
              check.command = "clippy";
              procMacro.enable = true;
              completion.autoimport.enable = true;
            };
          };
        };
      };
    };

    indent-blankline = {
      enable = true;
      settings = {
        indent.char = "│";
        exclude.filetypes = ["CHADTree"];
        scope = {
          enabled = true;
          show_end = false;
          show_start = false;
          injected_languages = true;
          priority = 500;
          highlight = [
            "Function"
            "Label"
          ];
        };
      };
    };

    typst-preview = {
      enable = true;
      settings = {
        extra_args = [
          "--input=compile-host=preview"
          # "--input "now=$(date '+%Y %m %d %H %M %S')""
        ];
      };
    };

    mini-files = {
      enable = true;
      settings = {
        mappings = {
          go_in_plus = "<CR>";
          close = "<ESC>";
        };
        windows = {
          preview = true;
        };
      };
    };
  };

  extraPlugins = [
    pkgs.vimPlugins.ultimate-autopair-nvim
  ];

  extraConfigLua = ''
    require('ultimate-autopair').setup({
      {'$','$',fly=true,dosuround=true,newline=true,space=true,ft = { 'typst', 'tex', 'plaintex' }},
    })
  '';

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
}
