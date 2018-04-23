package asw.jms.basicsynchconsumer;

import java.util.logging.Logger;

/**
 * SimpleSynchConsumerThread.java
 *
 * Un BasicSynchConsumerThread riceve una sequenza di messaggi tramite un BasicSynchConsumer.
 * Opera in un thread autonomo.
 * Quindi puo' operare in modo concorrente ad altri ConsumerThread.
 *
 * @author Luca Cabibbo
 */
public class BasicSynchConsumerThread extends Thread {

	/* logger */
	private Logger logger = Logger.getLogger("asw.jms.basicsynchconsumer");

	/** il consumer */
    private BasicSynchConsumer basicConsumer;

    /** nome del consumer */
    private String name;

    /**
     * Crea un nuovo BasicSynchConsumerThread per il consumer c.
     */
    public BasicSynchConsumerThread(BasicSynchConsumer c, String name) {
        super();
        this.basicConsumer = c;
        this.name = name;
    }

    /**
     * L'attivita' di questo thread.
     */
    public void run() {
		logger.info("ConsumerThread: " + name + " ready to receive messages");
    	basicConsumer.connect();
    	basicConsumer.start();
    	while (true) {
        	String message = basicConsumer.receiveMessage();
        	/* se e' arrivato un messaggio vuoto, 
        	 * allora interrompe la ricezione di messaggi */
        	if (message==null || message.length()==0)
        		break;
    	}
    	basicConsumer.stop();
        basicConsumer.disconnect();
    	logger.info("ConsumerThread: " + name + ": Done");
    }

}
