@Library('keptn-library@6.0.0-next.1')_
import sh.keptn.Keptn
import java.time.temporal.ChronoUnit

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.*;

def keptn = new sh.keptn.Keptn()

def getNow() {
  //return java.time.LocalDateTime.now() ;
  //return java.time.Instant.now().truncatedTo( ChronoUnit.MILLIS ) ;
  LocalDateTime localDateTime = LocalDateTime.now();
  ZonedDateTime zdt = ZonedDateTime.of(localDateTime, ZoneId.systemDefault());
  long date = zdt.toInstant().toEpochMilli();
  return date
}

def getNowID() {
  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("mmddHHMM");
  ZonedDateTime zdt = ZonedDateTime.now();
  String formattedZdt = zdt.format(formatter);
  return formattedZdt
}

pipeline {
    agent any
    
    environment {
    	def waitTime = 0
    }

    parameters {
         string(defaultValue: 'easytravel', description: 'Name of your Keptn Project you have setup for progressive delivery', name: 'Project', trim: false) 
         string(defaultValue: 'staging', description: 'First stage you want to deploy into', name: 'Stage', trim: false) 
         string(defaultValue: 'easytravel-mongodb', description: 'easytravel Mongo DB', name: 'Service1', trim: false)
         string(defaultValue: 'dynatrace/easytravel-mongodb', description: 'Mongo DB Image', name: 'Image1', trim: false)
         string(defaultValue: 'easytravel-backend', description: 'easytravel Backend', name: 'Service2', trim: false)
         string(defaultValue: 'dynatrace/easytravel-backend', description: 'easytravel Backend', name: 'Image2', trim: false)
         string(defaultValue: 'easytravel-frontend', description: 'easytracel Frontend', name: 'Service3', trim: false)
         string(defaultValue: 'dynatrace/easytravel-frontend', description: 'easytravel Frontend', name: 'Image3', trim: false)
         string(defaultValue: 'easytravel-www', description: 'easytravel nginx service', name: 'Service4', trim: false)
         string(defaultValue: 'dynatrace/easytravel-nginx', description: 'easytravel nginx', name: 'Image4', trim: false)
         string(defaultValue: 'easytravel-angular', description: 'easytravel nginx service', name: 'Service5', trim: false)
         string(defaultValue: 'dynatrace/easytravel-angular-frontend', description: 'easytravel amgular', name: 'Image5', trim: false)
		 choice(name: 'Release', choices: ["2.0.0.3356", "2.0.0.3349", "2.0.0.3322","2.0.0.3408"], description: 'EasyTravel Version')
         string(defaultValue: '20', description: 'How many minutes to wait until Keptn is done? 0 to not wait', name: 'WaitForResult')
         choice(name: 'DEPLOY_TO', choices: ["none", "all", "easytravelMongoDB", "easytravel-backend", "easytravel-frontend", "easytravel-www", "easytravel-angular"])
    }

    stages {        
        	stage('Trigger frontend') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "easytravel-frontend" } }
    		     steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver FrontEnd"
        			script {
					  // Initialize the Keptn Project
                      keptn.keptnInit project:"${params.Project}", service:"${params.Service3}", stage:"${params.Stage}"
					  def scriptStartTime = getNow().toString()
					  def buildid = getNowID().toString() 
				      //set a label
				      def labels=[:]
                      labels.put('TriggeredBy', 'Jenkins')
					  labels.put('version', "${params.Release}")
					  labels.put('buildId', "${buildid}")
        			  labels.put('evaltime', "${scriptStartTime}")					  
        			  // Deploy via keptn
        			  def keptnContext = keptn.sendDeliveryTriggeredEvent image:"${params.Image3}:${params.Release}", labels : labels
        			  String keptn_bridge = env.KEPTN_BRIDGE
        			  echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}
        		 }	
    		} 
    		stage('Trigger MongoDB') {
    			when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "easytravelMongoDB" } }
    			 steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver MongoDB"			   
        			script {
        			    keptn.keptnInit project:"${params.Project}", service:"${params.Service1}", stage:"${params.Stage}"
						def scriptStartTime = getNow().toString()
						def buildid = getNowID().toString()
        			    def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins')
					    labels.put('version', "${params.Release}")
					    labels.put('buildId', "${buildid}")
        			    labels.put('evaltime', "${scriptStartTime}")						 
        				def keptnContext = keptn.sendDeliveryTriggeredEvent image:"${params.Image1}:${params.Release}", labels : labels
        				String keptn_bridge = env.KEPTN_BRIDGE
        				echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}
        		}	
    		}
    		stage('Trigger backend') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "easytravel-backend" } }
    		     steps {
       				echo "Progressive Delivery: Triggering Keptn to deliver Backend"
        			script {
        			    keptn.keptnInit project:"${params.Project}", service:"${params.Service2}", stage:"${params.Stage}"
						def scriptStartTime = getNow().toString()
						def buildid = getNowID().toString()
        			    def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins')
					    labels.put('version', "${params.Release}")
					    labels.put('buildId', "${buildid}")
        			    labels.put('evaltime', "${scriptStartTime}") 
        				def keptnContext = keptn.sendDeliveryTriggeredEvent image:"${params.Image2}:${params.Release}", labels : labels
        				String keptn_bridge = env.KEPTN_BRIDGE
        				echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}	
				} 
    		}    
    		stage('Trigger www') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "easytravel-www" } }
    		     steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver www"
        			script {
        			    keptn.keptnInit project:"${params.Project}", service:"${params.Service4}", stage:"${params.Stage}"
						def scriptStartTime = getNow().toString()
						def buildid = getNowID().toString()
        				def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins')
					    labels.put('version', "${params.Release}")
					    labels.put('buildId', "${buildid}")
        			    labels.put('evaltime', "${scriptStartTime}")						
        				def keptnContext = keptn.sendDeliveryTriggeredEvent image:"${params.Image4}:${params.Release}", labels : labels 
        				String keptn_bridge = env.KEPTN_BRIDGE
        				echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}
        		 }
    		} 
		stage('Trigger angular') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "easytravel-angular" } }
    		     steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver angular"
        			script {
        			    keptn.keptnInit project:"${params.Project}", service:"${params.Service5}", stage:"${params.Stage}"
						def scriptStartTime = getNow().toString()
						def buildid = getNowID().toString()
        				def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins')
					    labels.put('version', "${params.Release}")
					    labels.put('buildId', "${buildid}")
        			    labels.put('evaltime', "${scriptStartTime}")						
        				def keptnContext = keptn.sendDeliveryTriggeredEvent image:"${params.Image5}:${params.Release}", labels : labels 
        				String keptn_bridge = env.KEPTN_BRIDGE
        				echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}
        		 }
    		}  
           stage('Wait for Result') {          
                 steps {             
            		script {                         
       					if(params.WaitForResult?.isInteger()) {
           					def waitTime = params.WaitForResult.toInteger()
       					}
       					if(waitTime > 0) {
           					echo "Waiting until Keptn is done and returns the results"
           					def result = keptn.waitForEvaluationDoneEvent setBuildResult:true, waitTime:waitTime
           					echo "${result}"
       					} else {
           					echo "Not waiting for results. Please check the Keptns bridge for the details!"
       					}
       	  			}	
       	  		}
	  		}    
  	}
} 
