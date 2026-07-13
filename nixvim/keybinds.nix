{ pkgs, helpers, ... }:
[
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
]
