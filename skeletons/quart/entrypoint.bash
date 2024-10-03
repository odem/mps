#!/bin/bash

if [[ ! -d .venv ]]; then
    python3 -m venv .venv
    pip install quart quart-cors
fi
source .venv/bin/activate
cd /opt/quart/skeleton/app || exit 123
python3 main.py
