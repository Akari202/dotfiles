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
    # pkgs.sops
    # pkgs.tombi
    # pkgs.oxfmt
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

    # diagnostic.virtual_text = false;

    plugins = {
      marks.enable = true;
      gitsigns.enable = true;
      web-devicons.enable = true;
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
      nvim-autopairs = {
        enable = true;
        settings = {
          enable_check_bracket_line = true;
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
            # toml = [ "tombi" ];
            # html = [ "oxfmt" ];
            # css = [ "oxfmt" ];
            # yaml = [ "oxfmt" ];
            # scss = [ "oxfmt" ];
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
          pylsp.enable = true;
          # pyrefly.enable = true;
          # tombi.enable = true;
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

      # indent-blankline-nvim = {
      #       enable = true;
      #       settings = {
      #         indent.char = "│";
      #         exclude.filetypes = [ "CHADTree" ];
      #         scope = {
      #           enabled = true;
      #           show_end = false;
      #           show_start = false;
      #           injected_languages = true;
      #           priority = 500;
      #           highlight = [
      #             "Function"
      #             "Label"
      #           ];
      #         };
      #       };
      #     };
      #
      # blink-cmp = {
      #       enable = true;
      #       settings = {
      #         keymap.preset = "default";
      #         sources.default = [
      #           "lsp"
      #           "path"
      #           "buffer"
      #           "snippets"
      #         ];
      #       };
      #     };
      #
      # typst-preview-nvim = {
      #       enable = true;
      #       settings = {
      #         extra_args = [ "--input=compile-host=preview", "--input "now=$(date '+%Y %m %d %H %M %S')"" ];
      #       };
      #     };
      #
      # oil-nvim = {
      #   enable = true;
      #   settings = {
      #     default_file_explorer = true;
      #     columns = [ "icon" ];
      #     view_options.show_hidden = false;
      #     win_options = {
      #       number = false;
      #       relativenumber = false;
      #       signcolumn = "no";
      #       foldcolumn = "no";
      #     };
      #   };
      # };
      #
      # visual-whitespace-nvim.enable = true
      #
      # nvim-treesitter-context.enable = true;
      # tiny-inline-diagnostic-nvim.enable = true;
    };

    extraPlugins = [
      # (pkgs.vimUtils.buildVimPlugin {
      #   name = "sops-nvim";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "trixnz";
      #     repo = "sops.nvim";
      #     rev = "4de0cb71746d7a6de6311c85bc39873e56bcefc7";
      #     hash = "sha256-pMnAGm7tkgM5pxhNEs06Qdx69qztMd14uNpuRi4I4qE=";
      #   };
      # })
      (pkgs.vimUtils.buildVimPlugin {
        name = "tiny-inline-diagnostic";
        src = pkgs.fetchFromGitHub {
          owner = "rachartier";
          repo = "tiny-inline-diagnostic.nvim";
          rev = "6264451f14119d63a52580e5198d6baf8518b0b2";
          hash = "sha256-pMnAGm7tkgM5pxhNEs06Qdx69qztMd14uNpuRi4I4qE=";
        };
      })
      (pkgs.vimUtils.buildVimPlugin {
        name = "nvim-treesitter-context";
        src = pkgs.fetchFromGitHub {
          owner = "nvim-treesitter";
          repo = "nvim-treesitter-context";
          rev = "b311b30818951d01f7b4bf650521b868b3fece16";
          hash = "sha256-pMnAGm7tkgM5pxhNEs06Qdx69qztMd14uNpuRi4I4qE=";
        };
      })
    ];

    extraConfigLua = ''
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
