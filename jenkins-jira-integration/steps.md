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

##################
## Jenkins
##################

## Manage Plugins

# Plugins name "Atlassian Jira Software Cloud" + "JIRA Trigger" + "JIRA"
# Manage Jenkins > Configure System screen and scroll to the Jira Software Cloud integration section.
# Select Add Jira Cloud Site > Jira Cloud Site. The Site name, ClientID, and Secret fields display.
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
*******************
## Generate snippets
*******************
# Go into a specific pipeline in Jenkins.

# From the left-hand menu, select Pipeline Syntax.

# In the Snippet Generator, select jiraSendDeploymentInfo or jiraSendBuildInfo, or checkGatingStatus from the dropdown list of Sample Steps and fill in the relevant details.

# Select Generate Pipeline Script and copy/paste the output into your Jenkinsfile, wherever you want to notify Jira
***************************************************************************************************************************
***************************************************************************************************************************

