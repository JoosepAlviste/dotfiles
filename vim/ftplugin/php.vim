" Minimal LSP configuration for PHP
if executable('php-language-server.php')
    " Use LanguageServer for omnifunc completion
    call LanguageClient_registerServerCommands({'php': ['php', '~/.composer/vendor/bin/php-language-server.php']})
else
    echo "php-language-server not installed!\n"
    :cq
endif

