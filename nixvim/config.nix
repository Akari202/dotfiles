{
  pkgs,
  lib,
  options,
  config,
  ...
}:
let
  helpers = pkgs.nixvim or config.lib.nixvim or { mkRaw = r: { __raw = r; }; };

  formatterBinaries = [
    pkgs.stylua
    pkgs.clang-tools
    pkgs.jq
    pkgs.tex-fmt
    pkgs.codespell
    pkgs.python3Packages.black
    pkgs.python3Packages.usort
    # pkgs.nixfmt
    pkgs.nixfmt-rfc-style
    # pkgs.tombi
    # pkgs.oxfmt
  ];

  keybinds = import ./keybinds.nix { inherit pkgs helpers; };
in
{
  config = {
    package = pkgs.neovim-unwrapped;
    extraPackages = formatterBinaries;
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
              }
            ];
            lualine_z = [ "tabs" ];
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
            rust = [ "rustfmt" ];
            python = [
              "black"
              "usort"
            ];
            json = [ "jq" ];
            lua = [ "stylua" ];
            c = [ "clang-format" ];
            cpp = [ "clang-format" ];
            tex = [ "tex-fmt" ];
            nix = [ "nixfmt" ];
            bib = [ "tex-fmt" ];
            "*" = [ "codespell" ];
            "_" = [ "trim_whitespace" ];
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
                globals = [ "vim" ];
              };
            };
          };
          clangd.enable = true;
          # pyright.enable = true;
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
                "html"
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
      # nvim-treesitter-context.enable = true;
      # tiny-inline-diagnostic-nvim.enable = true;
      # visual-whitespace-nvim.enable = true
      #
      # blink-cmp =
      #     {
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
      # typst-preview-nvim =
      #     {
      #       enable = true;
      #       settings = {
      #         extra_args = [ "--input=compile-host=preview" ];
      #       };
      #     };

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
    };

    colorschemes.one.enable = true;
  };
}
