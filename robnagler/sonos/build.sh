#!/bin/bash
build_fedora_base_image 21

build_as_root() {
    umask 022
    curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
    build_yum install nodejs
    cd /srv
    git clone https://github.com/jishi/node-sonos-http-api
    chown -R "$build_run_user:$build_run_user" node-sonos-http-api
}

build_as_run_user() {
    cd /srv/node-sonos-http-api
    npm install --production
    cat > start <<'EOF'
#!/bin/bash
cd "$(dirname "$0")"
npm start
EOF
    chmod +x start
}
