package asw.rmi.sessioncounter.client.connector;

import asw.rmi.sessioncounter.service.*;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import java.util.logging.Logger;

/* Factory per il servizio SessionCounter. */
public class ServiceFactory {

	/* registryHost e' "localhost" oppure "10.11.1.101" */
	/* per default e' "localhost" */
	private static final String DEFAULT_REGISTRY_HOST = "10.11.1.101";

	/* logger */
	private Logger logger = Logger.getLogger("asw.rmi.sessioncounter.client.connector");

	private static ServiceFactory instance = null;    // per singleton

    public static synchronized ServiceFactory getInstance() {
        if (instance==null) instance = new ServiceFactory();
        return instance;
    }

    /* Factory method per la factory del servizio session counter. */
    public SessionCounterFactory getSessionCounterFactory(String registryHost) {
    	SessionCounterFactory sessionCounterFactory = null;
    	/* ottiene un proxy al servizio remoto */
    	logger.info("ServiceFactory: Ora cerco la factory del servizio SessionCounter");
        /* crea il security manager */
    	if (System.getSecurityManager() == null) {
            System.setSecurityManager(new SecurityManager());
        }
        try {
        	/* cerca un riferimento alla factory del servizio remoto */
        	String sessionCounterFactoryName = "rmi:/asw/SessionCounterFactory";
            logger.info("ServiceFactory: looking for " + sessionCounterFactoryName + " on " + registryHost);
            Registry registry = LocateRegistry.getRegistry(registryHost);
            sessionCounterFactory = (SessionCounterFactory) registry.lookup(sessionCounterFactoryName);
            logger.info("ServiceFactory: " + sessionCounterFactoryName + " found");
        } catch (RemoteException e) {
        	logger.info("ServiceFactory: RemoteException: " + e.getMessage());
        } catch (NotBoundException e) {
        	logger.info("ServiceFactory: NotBoundException: " + e.getMessage());
        }
        return sessionCounterFactory;
    }

    public SessionCounterFactory getSessionCounterFactory() {
		return getSessionCounterFactory(DEFAULT_REGISTRY_HOST); 
    }	
	
    /* Factory method per il servizio session counter. */
    public SessionCounter getSessionCounter(String registryHost) {
    	SessionCounter sessionCounter = null;
    	/* ottiene la factory del session counter */
    	SessionCounterFactory sessionCounterFactory = getSessionCounterFactory(registryHost);
    	/* ora ottiene un riferimento al servizio remoto */
        try {
            logger.info("ServiceFactory: Getting a session counter from the factory");
            sessionCounter = sessionCounterFactory.getSessionCounter();
            int counterId = sessionCounter.getId();
            logger.info(
            		"ServiceFactory: Obtained a new session counter from the factory: "
            		+ "SessionCounter[" + counterId + "]"
            	);
        } catch (RemoteException e) {
        	logger.info("ServiceFactory: RemoteException: " + e.getMessage());
        }
        return sessionCounter;
    }

    public SessionCounter getSessionCounter() {
		return getSessionCounter(DEFAULT_REGISTRY_HOST); 
    }
	
	
}

