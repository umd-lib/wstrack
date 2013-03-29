import grails.util.Environment
// Place your Spring DSL code here
beans = {
	
	if (Environment.getCurrent() == Environment.DEVELOPMENT) {
		exportFile(org.springframework.jndi.JndiObjectFactoryBean){
			defaultObject = new String ("/tmp/wstrack.csv")
			jndiName = 'jsava:comp/env/exportFile'
		}

	} else if(Environment.getCurrent() == Environment.PRODUCTION) {
		exportFile(org.springframework.jndi.JndiObjectFactoryBean){
			jndiName = 'java:comp/env/exportFile'
		}
	}
}
