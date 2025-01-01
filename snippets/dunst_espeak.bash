#!/bin/bash
# Read out the notification message using espeak

# $1: Application name
# $2: Summary (title)
# $3: Body text

# Combine the title and body text into one message
MESSAGE="$2. $3"

# Use espeak to read the message
espeak "$MESSAGE" 
