#############
## JIRA
#############
    ## Create webhook
        # Setting
        # System
        # Webhook
        # Create new webhook
*********************************************************
    ## Create OAuth credential
        # Setting
        # App
        # OAuth credentials
        # Create OAuth
*********************************************************
    ## Create access token
        User logo on right top
        Account setting
        Security
        Create and Manage API token
        Create Token
        copy the secret key

##################
## Jenkins
##################

    ## Manage Plugins

        1. Plugins name "Atlassian Jira Software Cloud" + "JIRA Trigger Plugins" + "JIRA" + "JIRA Pipeline Steps" + "Jira-ext plugin" + "Atlassian Jira Software Cloud" + "Jira"
    
    ## Configure System 
    
        i. Jira Software Cloud Integration > ADD Jira Cloud Site. The Site name, ClientID, and Secret fields display.
            # Enter the following details:
                # Site name: The URL for your Jira Cloud site, for example yourcompany.atlassian.net.
                # Client ID: Copy from OAuth credentials screen (Client ID column).
                # Secret: Select Add > Jenkins.
                # For Kind, select Secret text.
                # For Secret, copy from OAuth credentials screen (Secret column).
                # For Description, provide a helpful description
                # Secret: Select your newly created secret.
                # Select Test connection to make sure your credentials are valid for your Jira site.
                # Select Save.

        ii. Jira > Jira Sites
                # Jira URL eg. https://raghib-world.atlassian.net/
                # create username and password in jenkins (pass is api token secret key and user is user login mail of jira)
                # check "Update Relevant Jira Issues For All Build Results"
                # select credential (which created in step 2)
                # validate setting
                # save

        iii. Jira Steps > jira sites

*******************
## Generate snippets
*******************
# Go into a specific pipeline in Jenkins.

# From the left-hand menu, select Pipeline Syntax.

# In the Snippet Generator, select jiraSendDeploymentInfo or jiraSendBuildInfo, or checkGatingStatus from the dropdown list of Sample Steps and fill in the relevant details.

# Select Generate Pipeline Script and copy/paste the output into your Jenkinsfile, wherever you want to notify Jira
***************************************************************************************************************************
***************************************************************************************************************************
