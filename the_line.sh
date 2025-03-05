#!/bin/bash

mapfile -t holidays < data/holidays.txt

last_commit_date=$(git log --pretty=format:"%ad" --date=iso --reverse | tail -n 1 | cut -d' ' -f1)

if [[ -z "$last_commit_date" ]]; then
  last_commit_date="$START_DATE"
else
  last_commit_date=$(date -I -d "$last_commit_date + 1 day")
fi

end_date=$(date +"%Y-%m-%d")
current_date="$last_commit_date"

while [[ "$current_date" < "$end_date" ]]; do
  num_commits=$((RANDOM % (MAX_COMMITS_PER_WEEKDAY - MIN_COMMITS_PER_WEEKDAY + 1) + MIN_COMMITS_PER_WEEKDAY))
  
  for ((i = 0; i < num_commits; i++)); do
    commit_message=$(shuf -n 1 data/commitment_to_the_line.txt)
    new_content_for_the_line=$(shuf -n 1 data/gospel_of_the_line.txt)

    sed -i "/LINE START/,/LINE END/{//!d;}" data/the_line.txt.txt
    sed -i "/LINE START/a $new_content_for_the_line" data/the_line.txt.txt

    echo "Commit on $current_date: $commit_message"
    git add data/the_line.txt.txt

    GIT_AUTHOR_DATE="$current_date" GIT_COMMITTER_DATE="$current_date" git commit -m "$commit_message"
  done

  current_date=$(date -I -d "$current_date + 1 day")
done

git push origin "$BRANCH_NAME"
