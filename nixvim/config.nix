{
  pkgs,
  lib,
  options,
  config,
  ...
}: let
  helpers = pkgs.nixvim or config.lib.nixvim or {mkRaw = r: {__raw = r;};};

  neededBinaries = [
    pkgs.stylua
    pkgs.clang-tools
    pkgs.jq
    pkgs.shfmt
    pkgs.fprettify
    pkgs.tex-fmt
    pkgs.codespell
    pkgs.python3Packages.black
    pkgs.python3Packages.usort
    pkgs.alejandra
    pkgs.sops
    pkgs.tombi
    pkgs.oxfmt
  ];

  keybinds = import ./keybinds.nix {inherit pkgs helpers;};
in {
  config = {
    package = pkgs.neovim-unwrapped;
    extraPackages = neededBinaries;
    keymaps = keybinds;

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

    #    diagnostic.virtual_text = false;

    plugins = {
      marks.enable = true;
      gitsigns.enable = true;
      web-devicons.enable = true;
      visual-whitespace.enable = true;
      treesitter-context.enable = true;
      tiny-inline-diagnostic.enable = true;

      colorizer = {
        enable = true;
        settings = {
          filetypes = ["*"];
          user_default_options = {
            names = false;
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

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            toml = ["tombi"];
            html = ["oxfmt"];
            css = ["oxfmt"];
            yaml = ["oxfmt"];
            scss = ["oxfmt"];
            rust = ["rustfmt"];
            sh = ["shfmt"];
            python = [
              "black"
              "usort"
            ];
            json = ["jq"];
            lua = ["stylua"];
            c = ["clang-format"];
            cpp = ["clang-format"];
            tex = ["tex-fmt"];
            fortran = ["fprettify"];
            nix = ["alejandra"];
            bib = ["tex-fmt"];
            "*" = ["codespell"];
            "_" = ["trim_whitespace"];
          };
          default_format_opts = {
            lsp_format = "fallback";
          };
          format_on_save = helpers.mkRaw ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
              return { timeout_ms = 2000 }
            end
          '';
          formatters = {
            rustfmt = {
              options = {
                nightly = true;
                default_edition = "2024";
              };
            };
          };
          notify_no_formatters = true;
          log_level = "debug";
        };
      };
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          lua_ls = {
            enable = true;
            settings.Lua = {
              diagnostics = {
                globals = ["vim"];
              };
            };
          };
          clangd.enable = true;
          fortls.enable = true;
          pyrefly.enable = true;
          ruff.enable = true;
          tombi.enable = true;
          tinymist = {
            enable = true;
            settings = {
              formatterMode = "typstyle";
              formatterPrintWidth = 100;
              formatterProseWrap = true;
              exportPdf = "never";
              semanticTokens = "enable";
              typstExtraArgs = [
                "--features"
                "bundle,html"
              ];
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

      blink-cmp-dictionary.enable = true;
      blink-ripgrep.enable = true;
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "super-tab";
          };
          sources = {
            default = [
              "lsp"
              "path"
              "buffer"
              "snippets"
              "dictionary"
              "ripgrep"
            ];
            providers = {
              dictionary = {
                module = "blink-cmp-dictionary";
                name = "Dict";
                score_offset = 100;
                min_keyword_length = 4;
              };
              ripgrep = {
                module = "blink-ripgrep";
                name = "Ripgrep";
                prefix_min_len = 3;
                opts = {
                  backend = {
                    use = "gitgrep-or-ripgrep";
                  };
                };
              };
            };
          };

          signature = {
            enabled = true;
            window.border = "rounded";
          };

          appearance = {
            use_nvim_cmp_as_default = true;
            nerd_font_variant = "mono";
          };

          completion = {
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 500;
              window.border = "rounded";
            };
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
  };
}
