{
  pkgs,
  lib,
  ...
}: {
  plugins = {
    blink-cmp-dictionary.enable = true;
    blink-ripgrep.enable = true;
    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "none";

          "<Tab>" = ["select_next" "snippet_forward" "fallback"];
          "<S-Tab>" = ["select_prev" "snippet_backward" "fallback"];
          "<CR>" = ["accept" "fallback"];
          # "<Esc>" = ["hide" "fallback"];
          "<C-e>" = ["hide" "fallback"];
          "<C-y>" = ["accept" "fallback"];

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
              score_offset = 100;
              min_keyword_length = 4;
            };
            ripgrep = {
              module = "blink-ripgrep";
              name = "Ripgrep";
              opts = {
                prefix_min_len = 3;
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
  };
}
