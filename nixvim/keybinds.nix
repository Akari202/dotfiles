{
  pkgs,
  helpers,
  ...
}: [
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
    key = "<leader>f";
    action = helpers.mkRaw ''
      function()
        local MiniFiles = require("mini.files")
        if not MiniFiles.close() then
          MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
        end
      end
    '';
  }
  {
    mode = "n";
    key = "<leader>r";
    action = helpers.mkRaw ''
      function()
        local MiniFiles = require("mini.files")
        if not MiniFiles.close() then
          MiniFiles.open(vim.fn.getcwd(), true)
        end
      end
    '';
  }
  {
    mode = "n";
    key = "s";
    action = helpers.mkRaw ''require("substitute").operator'';
    options = {
      noremap = true;
    };
  }
  {
    mode = "n";
    key = "ss";
    action = helpers.mkRaw ''require("substitute").line'';
    options = {
      noremap = true;
    };
  }
  {
    mode = "n";
    key = "S";
    action = helpers.mkRaw ''require("substitute").eol'';
    options = {
      noremap = true;
    };
  }
  {
    mode = "x";
    key = "s";
    action = helpers.mkRaw ''require("substitute").visual'';
    options = {
      noremap = true;
    };
  }
]
