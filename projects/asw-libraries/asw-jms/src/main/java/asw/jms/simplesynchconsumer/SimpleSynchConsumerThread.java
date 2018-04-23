package asw.jms.simplesynchconsumer;

import java.util.logging.Logger;

/**
 * CancellableSynchConsumerThread.java
 *
 * Un SimpleSynchConsumerThread riceve messaggi tramite un SimpleSynchConsumer.
 * Opera in un thread autonomo.
 * Quindi puo' operare in modo concorrente ad altri ConsumerThread.
 *
 * @author Luca Cabibbo
 */
public class SimpleSynchConsumerThread extends Thread {

	/* logger */
	private Logger logger = Logger.getLogger("asw.jms.simplesynchconsumer");

	/** il consumer */
    private SimpleSynchConsumer simpleConsumer;

    /** nome del consumer */
    private String name;

    /**
     * Crea un nuovo SimpleSynchConsumerThread per il consumer c.
     */
    public SimpleSynchConsumerThread(SimpleSynchConsumer c, String name) {
        super();
        this.simpleConsumer = c;
        this.name = name;
    }

    /**
     * L'attivita' di questo thread.
     */
    public void run() {
		logger.info("ConsumerThread: " + name + " ready to receive messages");
    	simpleConsumer.connect();
    	simpleConsumer.start();
    	while (true) {
        	simpleConsumer.receiveMessage();
        	/* se il consumatore e' stato cancellato, allora interrompe la ricezione di messaggi */
        	if (simpleConsumer.isCancelled())
        		break;
    	}
    	simpleConsumer.stop();
        simpleConsumer.disconnect();
    	logger.info("ConsumerThread: " + name + ": Done");
    }

}
