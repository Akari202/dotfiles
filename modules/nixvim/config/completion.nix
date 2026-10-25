{
  pkgs,
  lib,
  config,
  ...
}: {
  plugins = {
    friendly-snippets.enable = config.akari.extraTools.enable;
    blink-cmp-dictionary.enable = true;
    blink-ripgrep.enable = true;
    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "none";

          "<Tab>" = ["select_next" "fallback"];
          "<S-Tab>" = ["select_prev" "fallback"];
          "<CR>" = ["accept" "fallback"];
          # "<Esc>" = ["hide" "fallback"];
          "<C-e>" = ["hide" "fallback"];
          "<C-h>" = ["accept" "snippet_forward" "fallback"];

          "<C-Space>" = ["show" "show_documentation" "hide_documentation"];
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
              min_keyword_length = 4;
            };
            ripgrep = {
              module = "blink-ripgrep";
              name = "Ripgrep";
              opts = {
                prefix_min_len = 4;
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
          list.selection.preselect = false;

          documentation = {
            auto_show = true;
            auto_show_delay_ms = 500;
            window.border = "rounded";
          };
        };
      };
    };
  };
}
