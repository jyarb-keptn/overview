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
         string(defaultValue: 'keptnorders', description: 'Name of your Keptn Project you have setup for progressive delivery', name: 'Project', trim: false) 
         string(defaultValue: 'staging', description: 'First stage you want to deploy into', name: 'Stage', trim: false) 
         string(defaultValue: 'order', description: 'Order Service', name: 'orderService', trim: false)
         string(defaultValue: 'dtdemos/dt-orders-order-service', description: 'Order Service with Tag [:1.0.0,:2.0.0,:3.0.0,:4.0.0]', name: 'orderImage', trim: false)
         choice(name: 'OrderRelease', choices: ["1.0.0", "2.0.0", "3.0.0", "4.0.0"], description: 'Order Service with Tag [:1.0.0,:2.0.0,:3.0.0,:4.0.0]')
         string(defaultValue: 'customer', description: 'Customer Service', name: 'customerService', trim: false)
         string(defaultValue: 'dtdemos/dt-orders-customer-service', description: 'Customer Service with Tag [:1.0.0,:2.0.0:3.0.0]', name: 'customerImage', trim: false)
         choice(name: 'CustomerRelease', choices: ["1.0.0", "2.0.0", "3.0.0"], description: 'Customer Service with Tag [:1.0.0,:2.0.0,:3.0.0]')
         string(defaultValue: 'frontend', description: 'FrontEnd Service', name: 'frontendService', trim: false)
         string(defaultValue: 'dtdemos/dt-orders-frontend', description: 'Frontend Service with Tag [:1.0.0,:2.0.0:3.0.0]', name: 'frontendImage', trim: false)
		 choice(name: 'FrontendRelease', choices: ["1.0.0", "2.0.0", "3.0.0"], description: 'Frontend Service with Tag [:1.0.0,:2.0.0,:3.0.0]')
         string(defaultValue: 'catalog', description: 'Catalog Service', name: 'catalogService', trim: false)
         string(defaultValue: 'dtdemos/dt-orders-catalog-service:1.0.0', description: 'Tag:1.0.0', name: 'catalogImage', trim: false)
		 choice(name: 'CatalogRelease', choices: ["1.0.0", "2.0.0", "3.0.0"], description: 'Catalog Service with Tag [:1.0.0,:2.0.0,:3.0.0]')
         string(defaultValue: '20', description: 'How many minutes to wait until Keptn is done? 0 to not wait', name: 'WaitForResult')
         choice(name: 'DEPLOY_TO', choices: ["none", "all", "frontend", "order", "catalog", "customer"])
	}
	
        options {
           buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        }
	
	//    H */12 * * * %DEPLOY_TO=frontend
        //    H/15 */8 * * * %DEPLOY_TO=catalog
	//    H */12 * * * %OrderRelease=2.0.0;DEPLOY_TO=order
        //    H 0 * * * %OrderRelease=1.0.0;CustomerRelease=1.0.0;DEPLOY_TO=all

	triggers {
          parameterizedCron('''
              H */4 * * * %CustomerRelease=1.0.0;DEPLOY_TO=customer
              30 */4 * * * %OrderRelease=1.0.0;DEPLOY_TO=order
			  0 */8 * * * %OrderRelease=2.0.0;DEPLOY_TO=order
			  30 */8 * * * %CatalogRelease=2.0.0;DEPLOY_TO=catalog
			  0 */12 * * * %FrontendRelease=2.0.0;DEPLOY_TO=frontend
        ''')
	}


    stages {        
        	stage('Trigger FrontendService') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "frontend" } }
    		     steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.frontendImage}"
        			script {
					  // Initialize the Keptn Project
                      keptn.keptnInit project:"${params.Project}", service:"${params.frontendService}", stage:"${params.Stage}"
					  def scriptStartTime = getNow().toString()
					  def buildid = getNowID().toString()
					  //set a label
				      def labels=[:]
                      labels.put('TriggeredBy', 'Jenkins')
					  labels.put('version', "${params.FrontendRelease}")
					  labels.put('buildId', "${buildid}")
        			  labels.put('evaltime', "${scriptStartTime}")					  
        			  // Deploy via keptn
        			  def keptnContext = keptn.sendDeliveryTriggeredEvent image:"${params.frontendImage}:${params.FrontendRelease}", labels : labels
        			  String keptn_bridge = env.KEPTN_BRIDGE
        			  echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}
        		 }	
    		} 
    		stage('Trigger orderService') {
    			when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "order" } }
    			 steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.orderImage}"			   
        			script {
        			    keptn.keptnInit project:"${params.Project}", service:"${params.orderService}", stage:"${params.Stage}"
						def scriptStartTime = getNow().toString()
						def buildid = getNowID().toString()
        			    def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins')
						labels.put('version', "${params.OrderRelease}")
						labels.put('buildId', "${buildid}")
        			    labels.put('evaltime', "${scriptStartTime}") 
        				def keptnContext = keptn.sendDeliveryTriggeredEvent image:"${params.orderImage}:${params.OrderRelease}", labels : labels
        				String keptn_bridge = env.KEPTN_BRIDGE
        				echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}
        		}	
    		}
    		stage('Trigger customerService') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "customer" } }
    		     steps {
       				echo "Progressive Delivery: Triggering Keptn to deliver ${params.customerImage}"
        			script {
        			    keptn.keptnInit project:"${params.Project}", service:"${params.customerService}", stage:"${params.Stage}"
						def scriptStartTime = getNow().toString()
						def buildid = getNowID().toString()
        			    def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins')
						labels.put('version', "${params.CustomerRelease}")
						labels.put('buildId', "${buildid}")
        			    labels.put('evaltime', "${scriptStartTime}") 
        				def keptnContext = keptn.sendDeliveryTriggeredEvent image:"${params.customerImage}:${params.CustomerRelease}", labels : labels
        				String keptn_bridge = env.KEPTN_BRIDGE
        				echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}	
				} 
    		}    
    		stage('Trigger CatalogService') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "catalog" } }
    		     steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.catalogImage}"
        			script {
        			    keptn.keptnInit project:"${params.Project}", service:"${params.catalogService}", stage:"${params.Stage}"
						def scriptStartTime = getNow().toString()
						def buildid = getNowID().toString()
        				def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins')
						labels.put('version', "${params.CatalogRelease}")
						labels.put('buildId', "${buildid}")
        			    labels.put('evaltime', "${scriptStartTime}")
        				def keptnContext = keptn.sendDeliveryTriggeredEvent image:"${params.catalogImage}:${params.CatalogRelease}", labels : labels 
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
