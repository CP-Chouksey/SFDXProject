#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME

    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH

    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY
println  "SFDX:?" 
    def toolbelt =  'toolbelt'
println  "${toolbelt}/sfdx" 
		    
    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }

    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
        stage('Deploye Code') {
	    println 'Running on Window.......'
	   rc = bat returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            //println 'DevHub authentication Done.......'

	    //rc = bat returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username test-47omgaladoqv@example.com --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl https://login.salesforce.com"
            println 'Scratch Org authentication Done.......'
	    if (rc != 0) { error 'Org authorization failed....' }
	    println rc
            println 5
	    rmsg = bat returnStdout: true, script: "sfdx force:org:list"
            println rmsg
            println 10
	   
        }
    }
}
