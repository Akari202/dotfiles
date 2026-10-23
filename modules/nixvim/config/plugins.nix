{
  pkgs,
  lib,
  ...
}: let
  helpers = lib.nixvim;
in {
  extraPackages = with pkgs; [
    rustMonthly
    rustAnalyzerMonthly
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
      highlight.enable = true;
      indent.enable = true;
    };
    rustaceanvim = {
      enable = true;
      settings = {
        tools.enable_clippy = true;
        server = {
          standalone = false;
          cmd = [
            "rust-analyzer"
          ];
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
              check = {
                command = "clippy";
              };
              inlayHints = {
                lifetimeElisionHints = {
                  enable = "always";
                };
              };
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
}
