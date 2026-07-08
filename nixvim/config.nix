{ pkgs, ... }:
let
  helpers = pkgs.nixvim or { mkRaw = r: { __raw = r; }; };
  # helpers = config.lib.nixvim;
  formatterBinaries = [
    pkgs.stylua
    pkgs.clang-tools
    pkgs.jq
    pkgs.nixfmt-rfc-style
    pkgs.tex-fmt
    pkgs.codespell
    pkgs.python312Packages.black
    pkgs.python312Packages.usort
    # pkgs.oxfmt
    # pkgs.tombi
  ];
in
{
  options = { };

  config = {
    # enable = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = formatterBinaries;

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

    keymaps = [
      {
        mode = "n";
        key = "j";
        action = "gj";
      }
      {
        mode = "n";
        key = "gj";
        action = "j";
      }
      {
        mode = "n";
        key = "k";
        action = "gk";
      }
      {
        mode = "n";
        key = "gk";
        action = "k";
      }

      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
      }
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
      }

      {
        mode = "n";
        key = "<leader>h";
        action = "<cmd>noh<CR>";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = ":bp<bar>bd #<CR>";
      }

      {
        mode = "v";
        key = "<";
        action = "<gv";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
      }

      {
        mode = "n";
        key = "<leader>P";
        action = "<cmd>put +<CR>";
      }
      {
        mode = "n";
        key = "<leader>O";
        action = "<cmd>put! +<CR>";
      }

      {
        mode = "n";
        key = "]e";
        action = helpers.mkRaw "function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end";
      }
      {
        mode = "n";
        key = "[e";
        action = helpers.mkRaw "function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end";
      }
      {
        mode = "n";
        key = "<F7>";
        action = helpers.mkRaw ''
          function()
            local sidebar_win = nil
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].filetype == "oil" then
                sidebar_win = win
                break
              end
            end

            if sidebar_win then
              vim.api.nvim_win_close(sidebar_win, true)
            else
              vim.cmd("topleft vsplit")
              vim.cmd("vertical resize 30")
              
              require("oil").open()
              
              local buf = vim.api.nvim_get_current_buf()
              local win = vim.api.nvim_get_current_win()
              vim.wo[win].winfixwidth = true
              vim.wo[win].winfixbuf = true
            end
          end
        '';
      }
    ];

    plugins = {
      marks.enable = true;
      gitsigns.enable = true;
      web-devicons.enable = true;
      airline = {
        enable = true;
        settings = {
          theme = "one";
          powerline_fonts = 1;
          extensions_tabline_enabled = true;
          extensions_tabline_formatter = "unique_tail";
          section_c_only_filename = 1;
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
      # nvim-treesitter-context.enable = true;
      # indent-blankline-nvim = {
      #   enable = true;
      #   settings = {
      #     indent.char = "│";
      #     exclude.filetypes = [ "CHADTree" ];
      #     scope = {
      #       enabled = true;
      #       show_end = false;
      #       show_start = false;
      #       injected_languages = true;
      #       priority = 500;
      #       highlight = [
      #         "Function"
      #         "Label"
      #       ];
      #     };
      #   };
      # };
      # tiny-inline-diagnostic-nvim = {
      #   enable = true;
      #   settings.options.virt_text_opts.mapping = {
      #     native_virtual_text = false;
      #   };
      # };
      # blink-cmp = {
      #   enable = true;
      #   settings = {
      #     keymap.preset = "default";
      #     sources.default = [
      #       "lsp"
      #       "path"
      #       "buffer"
      #       "snippets"
      #     ];
      #   };
      # };
      # typst-preview-nvim = {
      #   enable = true;
      #   settings = {
      #     extra_args = [ "--input=compile-host=preview" ];
      #   };
      # };
      # oil-nvim = {
      #   enable = true;
      #   settings = {
      #     default_file_explorer = true;
      #     columns = [ "icon" ];
      #     view_options = {
      #       show_hidden = false;
      #     };
      #     win_options = {
      #       number = false;
      #       relativenumber = false;
      #       signcolumn = "no";
      #       foldcolumn = "no";
      #     };
      #   };
      # };
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            rust = [ "rustfmt" ];
            python = [
              "black"
              "usort"
            ];
            toml = [ "tombi" ];
            json = [ "jq" ];
            lua = [ "stylua" ];
            c = [ "clang-format" ];
            cpp = [ "clang-format" ];
            tex = [ "tex-fmt" ];
            nix = [ "nixfmt" ];
            bib = [ "tex-fmt" ];
            html = [ "oxfmt" ];
            css = [ "oxfmt" ];
            yaml = [ "oxfmt" ];
            scss = [ "oxfmt" ];
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
          lua_ls.enable = true;
          clangd.enable = true;
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
                "html"
              ];
            };
          };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-one
      # visual-whitespace-nvim
    ];

    # Apply the visual theme choice directly on initialization
    colorscheme = "one";
  };
}
