return {
    "huggingface/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = function()
        return {
            backend = "openai",
            url = "http://127.0.0.1:1234",
            model = "meta-llama-3.1-8b-instruct",
            api_token = "lm-studio",
            debounce_ms = 100,
            max_tokens = 64,
            -- Explicitly disable FIM and Context for this test
            fim = { enabled = false },
            context_window = 2048,
            enable_suggestions_on_startup = true,
            enable_suggestions_on_files = "*",
        }
    end,
    keys = {
        { "<leader>ai", "<cmd>LLMSuggestion<CR>",        desc = "Manual AI Trigger" },
        { "<leader>at", "<cmd>LLMToggleAutoSuggest<CR>", desc = "Toggle Auto-Suggest" },
    },
}
