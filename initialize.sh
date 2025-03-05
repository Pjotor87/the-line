#!/bin/bash

# Check if Git user details are already set
existing_user=$(git config --global user.name)
existing_email=$(git config --global user.email)

if [[ -z "$existing_user" ]]; then
  read -p "Enter your Git username: " GIT_USER_NAME
  git config --global user.name "$GIT_USER_NAME"
  echo "Git username set to '$GIT_USER_NAME'."
else
  echo "Git user.name is already set to '$existing_user'."
fi

if [[ -z "$existing_email" ]]; then
  read -p "Enter your Git email: " GIT_USER_EMAIL
  git config --global user.email "$GIT_USER_EMAIL"
  echo "Git email set to '$GIT_USER_EMAIL'."
else
  echo "Git user.email is already set to '$existing_email'."
fi

# Check if GITHUB_USERNAME is set in config.cfg, prompt if not
if [[ -z "$GITHUB_USERNAME" ]]; then
  read -p "Enter your GitHub username: " GITHUB_USERNAME
  
  # Modify the existing GITHUB_USERNAME line in config.cfg
  sed -i "s|^export GITHUB_USERNAME=.*|export GITHUB_USERNAME=\"$GITHUB_USERNAME\"|" config.cfg

  echo "GitHub username saved as '$GITHUB_USERNAME'."
else
  echo "GitHub username is already set to '$GITHUB_USERNAME'."
fi
