{
  pkgs,
  lib,
  config,
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
      fortls.enable = config.akari.extraTools.enable;
      pyrefly.enable = config.akari.extraTools.enable;
      ruff.enable = config.akari.extraTools.enable;
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
        enable = config.akari.extraTools.enable;
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
