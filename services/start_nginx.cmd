@echo off

REM set PHP_FCGI_CHILDREN=5
set PHP_FCGI_MAX_REQUESTS=1000

echo Starting PHP FastCGI...
RunHiddenConsole d:/lib/php/php-cgi.exe -b 127.0.0.1:9000 -c d:/lib/php/php.ini

echo Starting nginx...

RunHiddenConsole d:/lib/nginx/nginx-1.15.1/nginx.exe -p d:/lib/nginx/nginx-1.15.1
