#!/bin/bash

if [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]]; then
    # See: https://github.com/coreybutler/nvm-windows#usage
    if [ -n "$NODE_PARAM_VERSION" ]; then
        # nvm-windows supports "latest" and "lts" as possible values
        nvm install "$NODE_PARAM_VERSION";
    elif [ -f ".nvmrc" ]; then
        NVMRC_SPECIFIED_VERSION=$(<.nvmrc);
        nvm install "$NVMRC_SPECIFIED_VERSION";
    else
        nvm install lts;
    fi

    echo 'nvm use newest &>/dev/null' >> "$BASH_ENV";
else
    # See: https://github.com/nvm-sh/nvm#usage
    if [ "$NODE_PARAM_VERSION" = "latest" ]; then
        # When no version is specified we default to the latest version of Node
        NODE_ORB_INSTALL_VERSION=$(nvm ls-remote | tail -n1 | grep -Eo 'v[0-9]+\.[0-9]+\.[0-9]+');
        nvm install -b --default "$NODE_ORB_INSTALL_VERSION"; # aka nvm install node. We're being explicit here.
    elif [ -n "$NODE_PARAM_VERSION" ] && [ "$NODE_PARAM_VERSION" != "lts" ]; then
        nvm install -b --default "$NODE_PARAM_VERSION";
    elif [ -f ".nvmrc" ]; then
        NVMRC_SPECIFIED_VERSION=$(<.nvmrc);
        nvm install -b --default "$NVMRC_SPECIFIED_VERSION";
    else
        nvm install -b --default --lts;
    fi

    echo 'nvm use default &>/dev/null' >> "$BASH_ENV";
fi
