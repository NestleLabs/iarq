# dns-server

## Prerequisites:
    * ruby 2.6.0
    * bundler 2.0

## Usage
    1. start dns server
    ```ruby
    cd <to-project-directory>
    ./server udp 127.0.0.1 53 domain.org
    ```
    
    2. query dns
    ```bash
        dig @localhost -p <port> <domain>
    ```
