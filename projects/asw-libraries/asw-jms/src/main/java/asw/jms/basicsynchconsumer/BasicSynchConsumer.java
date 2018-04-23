package asw.jms.basicsynchconsumer;

import javax.jms.*;

import java.util.logging.Logger;

import asw.util.sleep.Sleeper;
import asw.jndi.JndiUtil; 

/**
 * BasicSynchConsumer.java
 *
 * Un BasicSynchConsumer e' un endpoint per ricevere messaggi
 * da una generica destinazione JMS (coda o argomento).
 * La ricezione dei messaggi avviene secondo la modalita' sincrona.

 * Introduce un ritardo per simulare il tempo di elaborazione
 * di ciascun messaggio.
 *
 * I messaggi sono inviati da SimpleProducer.
 *
 * Variante di un esempio nel tutorial per Java EE.
 *
 * @author Luca Cabibbo
 */
public class BasicSynchConsumer {

	/* logger */
	private Logger logger = Logger.getLogger("asw.jms.basicsynchconsumer");

	/* nome di questo consumer */
    private String name;
    /* destinazione di questo consumer */
    private Destination destination;
    /* connection factory di questo consumer */
    private ConnectionFactory connectionFactory;

    /* ritardo massimo tra messaggi */
    private int maxDelay;

    /* numero di messaggi consumati finora */
    private int messagesReceived;

    /* contesto jms */
    private JMSContext context = null;
    /* per la ricezione di messaggi da destination */
    private JMSConsumer messageConsumer = null;

    /**
     * Crea un nuovo BasicSynchConsumer, di nome n, per una destinazione d.
     */
    public BasicSynchConsumer(String n, String d, String cf, int maxDelay) {
        this.name = n;
        this.destination = (Destination) JndiUtil.getInstance().jndiLookup(d);
        this.connectionFactory = (ConnectionFactory) JndiUtil.getInstance().jndiLookup(cf);
        this.maxDelay = maxDelay;

        this.messagesReceived = 0;
    }
	
    /**
     * Crea un nuovo BasicSynchConsumer, di nome n, per una destinazione d.
     */
    public BasicSynchConsumer(String n, Destination d, ConnectionFactory cf, int maxDelay) {
        this.name = n;
        this.destination = d;
        this.connectionFactory = cf;
        this.maxDelay = maxDelay;

        this.messagesReceived = 0;
    }

    /**
     * Apre la connessione alla destinazione JMS di questo consumer.
     */
    public void connect() {
    	logger.info(this.toString() + ": Connecting...");
        context = connectionFactory.createContext();
    	messageConsumer = context.createConsumer(destination);
    	logger.info(this.toString() + ": Connected");
    }

    /**
     * Si disconnette dalla destinazione JMS di questo consumer.
     */
    public void disconnect() {
        if (context != null) {
        	logger.info(this.toString() + ": Disconnecting...");
            context.close();
            context = null;
        	logger.info(this.toString() + ": Disconnected (" + messagesReceived + " message(s) received)");
        }
    }

    /**
     * Avvia la ricezione dei messaggi di questo consumer.
     */
    public void start() {
        /* avvia la ricezione di messaggi per la connessione */
    	logger.info(this.toString() + ": Starting message reception");
        context.start();
    }

    /**
     * Arresta la ricezione dei messaggi di questo consumer.
     */
    public void stop() {
        /* arresta la ricezione di messaggi per la connessione */
    	logger.info(this.toString() + ": Stopping message reception");
        context.stop();
    }

    /**
     * Riceve un messaggio dalla destinazione.
     */
    public String receiveMessage() {

        /* riceve un messaggio dalla destinazione di questo consumer */
        try {
            /* riceve un messaggio */
            Message m = messageConsumer.receive();
            if (m instanceof TextMessage) {
            	TextMessage message = (TextMessage) m;
            	this.messagesReceived++;
                logger.info(this.name + ": Reading message #" + this.messagesReceived + ": " + message.getText());
    			/* introduce un ritardo */
    			Sleeper.randomSleep(maxDelay/2, maxDelay);
                return message.getText();
            }
        } catch (JMSException e) {
            logger.info(this.toString()+ ": Error while reading message: " + e.toString());
            System.exit(1);
        }
        return null;
    }

    /**
     * Restituisce una descrizione di questo consumer.
     */
    public String toString() {
        return "BasicSynchConsumer[" +
                "name=" + name +
                ", maxDelay=" + maxDelay +
//                ", reading from=" + destination.toString() +
                "]";
    }

}
