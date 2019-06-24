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
	
	def scratchOrg = 'demoSOrg4'
	
	stage('checkout source') {
		// when running in multi-branch job, one must issue this command
		checkout scm
	}
	doError = '1'
	withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
		stage('Deploye Code') {
			println 'Running on Window.......'
			
			rc = bat returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
			//println 'DevHub authentication Done.......'
			
			//rc = bat returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username test-47omgaladoqv@example.com --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl https://login.salesforce.com"
			println 'Scratch Org authentication .......'
			if (rc != 0) { error 'Org authorization failed....' }
			println rc
			println 5
			
			rc = bat returnStatus: true, script: "sfdx force:org:create -s -f config/project-scratch-def.json -a ${scratchOrg}"
			if (rc != 0) { error 'SFDX Command failed....2' }
			println rc
			println 20
			
			rc = bat returnStatus: true, script: "sfdx force:user:password:generate --targetusername ${scratchOrg}"
			if (rc != 0) { error 'SFDX Command failed....22' }
			println rc
			println 22
			rc = bat returnStatus: true, script: "sfdx force:user:display --targetusername ${scratchOrg}"
			if (rc != 0) { error 'SFDX Command failed....23' }
			println rc
			println 23
			
			rc = bat returnStatus: true, script: "sfdx force:source:push -u ${scratchOrg}"
			if (rc != 0) { error 'SFDX Command failed....4' }
			println rc
			println 40
			
			rc = bat returnStatus: true, script: "sfdx force:org:list --all"
			if (rc != 0) { error 'SFDX Command failed....4' }
			println rc
			println 50
			
			doError = '0'
			/*		
			def subject = "JENKINS-NOTIFICATION: : Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'" 
			
			emailext(
			mimeType: 'text/html',
			replyTo: '$DEFAULT_REPLYTO',
			subject: subject,
			from: 'chnadra@comitydesigns.com',
			to: 'chandra@comitydesigns.com',
			body: '${SCRIPT,template="email.template"}',
			attachLog: true,
			compressLog: true,
			recipientProviders: [[$class: 'DevelopersRecipientProvider']]
			)
			*/
		}
	}
}
