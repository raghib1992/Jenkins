*******************************URL*********************************************
https://jenkinsci.github.io/job-dsl-plugin/
*******************************************************************************

job('<job_name>'){

   description('You can add your description here')
   
   paramters{
     stringParam('NAME', defaultValue = 'Nadim', description = 'This is my name')
     boolenParam('FLAG', true)
     choiceParam('OPTION', ['option 1 (default)', 'option 2', 'option 3')]
   }
   
   scm {
        github('jenkinsci/job-dsl-plugin', 'master')
    }
    
    triggers {
        cron('H 5 * * * *')
    }
    
    steps{
        SHELL("""
                 echo 'hello world'
                 echo 'now the date and time is $(date)'
              """
         )
    }
     
     publishers {
        mailer('me@example.com', true, true)         # email notification
    }

}
