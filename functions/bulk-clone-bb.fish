function bulk-clone-bb -a USER PASSWORD OWNER -d "Bulk clone bitbucket repositories"
    curl -u $USER:$PASSWORD "https://api.bitbucket.org/2.0/repositories/$OWNER?pagelen=100" \
    | jq -r '.values[] | "\(.scm) \(.name)"' \
    | while read REPO_TYPE REPO_NAME
        echo cloning $REPO_NAME
        switch $REPO_TYPE
            case git
                git clone git@bitbucket.org:$OWNER/$REPO_NAME.git $REPO_NAME --mirror 
            case hg
                hg clone ssh://hg@bitbucket.org/$OWNER/$REPO_NAME $REPO_NAME
        end
      end
end
