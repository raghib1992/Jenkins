# Install job-DSL plugins

# Create Jib
```
job('job_dsl_created'){
    description('This is my awesome job')

    parameters {
        stringParam('PLanet', defaultValue = 'World', descritpiton = 'Green Planet')
        booleanParam('FLAG', true)
        choiceParam('OPTION', ['option 1 (default)','option 2', 'option 3'])
    }
    
    scm {
        git('https://github.com/raghib1992/html.git', 'main')
    }

    triggers {
        cron('H 5 * * 7')
    }

    steps {
        shell ("echo 'Hello World'")
    }

    steps {
        shell("""
        echo 'Hi ! there'
        echo 'How are you'
        """)
    }

    publishers {
        mailer('me@example.com', true, true)
    }
}
```

