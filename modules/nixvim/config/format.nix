{
  pkgs,
  lib,
  config,
  ...
}: let
  helpers = lib.nixvim;
in {
  extraPackages = with pkgs;
    [
      alejandra
      codespell
      jq
      shfmt
      tombi
      oxfmt
      stylua
    ]
    ++ lib.optionals config.akari.extraTools.enable [
      clang-tools
      fprettify
      tex-fmt
      unstable.typstyle
      python3Packages.black
      python3Packages.usort
    ]
    ++ lib.optionals config.akari.rust.enable [
      rustMonthly
    ];

  plugins.conform-nvim = {
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
        typst = ["typstyle"];
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
        typstyle = {
          prepend_args = [
            "--line-width"
            "100"
            "--indent-width"
            "2"
            "--wrap-text"
          ];
        };
      };
      notify_no_formatters = true;
      log_level = "debug";
    };
  };
}
