{
  pkgs,
  lib,
  ...
}: {
  plugins.lsp = {
    enable = true;
    servers = {
      # matlab_ls.enable = true;
      nixd.enable = true;
      # basedpyright.enable = true;
      bashls.enable = true;
      clangd.enable = true;
      fortls.enable = true;
      pyrefly.enable = true;
      ruff.enable = true;
      tombi.enable = true;
      lua_ls = {
        enable = true;
        settings.Lua = {
          diagnostics = {
            globals = ["vim"];
          };
        };
      };
      tinymist = {
        enable = true;
        settings = {
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
}
