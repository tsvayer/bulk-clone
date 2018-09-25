function bulk-clone-gh -a USER -d "Bulk clone of github repositories"
  curl https://api.github.com/users/$USER/repos \
    | jq -r '.[] | "\(.name)"' \
    | while read REPO_NAME
        echo cloning $REPO_NAME
        git clone git@github.com:$USER/$REPO_NAME.git $REPO_NAME --mirror
      end
end
