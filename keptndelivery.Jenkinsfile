@Library('keptn-library@master')_
import sh.keptn.Keptn
def keptn = new sh.keptn.Keptn()

pipeline {
    agent any
    
    environment {
    	def waitTime = 0
    }

    parameters {
         string(defaultValue: 'keptnorders', description: 'Name of your Keptn Project you have setup for progressive delivery', name: 'Project', trim: false) 
         string(defaultValue: 'staging', description: 'First stage you want to deploy into', name: 'Stage', trim: false) 
         string(defaultValue: 'order', description: 'Order Service', name: 'orderService', trim: false)
         string(defaultValue: 'docker.io/dtdemos/dt-orders-order-service', description: 'Order Service with Tag [:1.0.0,:2.0.0,:3.0.0,:4.0.0]', name: 'orderImage', trim: false)
         choice(name: 'OrderRelease', choices: ["1.0.0", "2.0.0", "3.0.0", "4.0.0"], description: 'Order Service with Tag [:1.0.0,:2.0.0,:3.0.0,:4.0.0]')
         string(defaultValue: 'customer', description: 'Customer Service', name: 'customerService', trim: false)
         string(defaultValue: 'docker.io/dtdemos/dt-orders-customer-service', description: 'Customer Service with Tag [:1,:2:3]', name: 'customerImage', trim: false)
         choice(name: 'CustomerRelease', choices: ["1.0.0", "2.0.0", "3.0.0"], description: 'Customer Service with Tag [:1,:2,:3]')
         string(defaultValue: 'frontend', description: 'FrontEnd Service', name: 'frontendService', trim: false)
         string(defaultValue: 'docker.io/dtdemos/dt-orders-frontend:1.0.0', description: 'Tag:1.0.0', name: 'frontendImage', trim: false)
         string(defaultValue: 'catalog', description: 'Catalog Service', name: 'catalogService', trim: false)
         string(defaultValue: 'docker.io/dtdemos/dt-orders-catalog-service:1.0.0', description: 'Tag:1.0.0', name: 'catalogImage', trim: false)
         string(defaultValue: '20', description: 'How many minutes to wait until Keptn is done? 0 to not wait', name: 'WaitForResult')
         choice(name: 'DEPLOY_TO', choices: ["none", "all", "frontend", "order", "catalog", "customer"])
	}
	
        options {
           buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        }
	
	triggers {
          parameterizedCron('''
        //    H */12 * * * %DEPLOY_TO=frontend
        //    H/15 */8 * * * %DEPLOY_TO=catalog
              H */8 * * * %CustomerRelease=1.0.0;DEPLOY_TO=customer
              H */8 * * * %OrderRelease=1.0.0;DEPLOY_TO=order
	//    H */12 * * * %OrderRelease=2.0.0;DEPLOY_TO=order
        //    H 0 * * * %OrderRelease=1.0.0;CustomerRelease=1.0.0;DEPLOY_TO=all
        ''')
	}


    stages {        
        	stage('Trigger FrontendService') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "frontend" } }
    		     steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.frontendImage}"
        			script {
					  // Initialize the Keptn Project
                      keptn.keptnInit project:"${params.Project}", service:"${params.frontendService}", stage:"${params.Stage}", monitoring:"dynatrace" 
				      //set a label
				      def labels=[:]
                      labels.put('TriggeredBy', 'Jenkins')
        			  // Deploy via keptn
        			  def keptnContext = keptn.sendConfigurationChangedEvent image:"${params.frontendImage}", labels : labels
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
        			    keptn.keptnInit project:"${params.Project}", service:"${params.orderService}", stage:"${params.Stage}", monitoring:"dynatrace"
        			    def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins') 
        				def keptnContext = keptn.sendConfigurationChangedEvent image:"${params.orderImage}:${params.OrderRelease}", labels : labels
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
        			    keptn.keptnInit project:"${params.Project}", service:"${params.customerService}", stage:"${params.Stage}", monitoring:"dynatrace"
        			    def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins') 
        				def keptnContext = keptn.sendConfigurationChangedEvent image:"${params.customerImage}:${params.CustomerRelease}", labels : labels
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
        			    keptn.keptnInit project:"${params.Project}", service:"${params.catalogService}", stage:"${params.Stage}", monitoring:"dynatrace"
        				def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins')
        				def keptnContext = keptn.sendConfigurationChangedEvent image:"${params.catalogImage}", labels : labels 
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
