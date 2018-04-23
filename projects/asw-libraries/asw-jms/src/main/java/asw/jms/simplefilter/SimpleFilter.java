package asw.jms.simplefilter;

import asw.jms.simpleasynchconsumer.SimpleAsynchConsumer;
import asw.jms.simplemessagefilter.SimpleMessageFilter;
import asw.jms.simplemessageprocessor.SimpleMessageProcessor;
import asw.jms.simpleproducer.SimpleProducer;

import javax.jms.ConnectionFactory;
import javax.jms.Destination;

import asw.util.cancellable.Cancellable;
import asw.util.sleep.Sleeper;
import asw.jndi.JndiUtil; 

import java.util.logging.Logger;

/**
 * Un SimpleFilter e' un endpoint che legge messaggi da una destinazione JMS
 * e, in corrispondenza, invia messaggi a un'altra destinazione JMS.
 *
 * Il filtraggio dei messaggi viene effettuato da un SimpleMessageFilter. 
 * 
 * Questo filter e' anche un consumatore di messaggi testuali,
 * poiche' implementa SimpleMessageProcessor.
 *
 * Introduce un ritardo per simulare il tempo di elaborazione
 * di ciascun messaggio.
 *
 * I messaggi in ingresso possono essere inviati da un SimpleProducer.
 * I messaggi in uscita possono essere consumati da un SimpleXConsumer.
 *
 * @author Luca Cabibbo
 */
public class SimpleFilter implements Cancellable, SimpleMessageProcessor {

	/* logger */
	private static Logger logger = Logger.getLogger("asw.jms.simplefilter");

	/* nome di questo filtro */
    private String name;
    /* la destinazione da cui questo filtro legge messaggi */
    private Destination messageSource;
    /* la destinazione a cui questo filtro invia messaggi */
    private Destination messageDestination;
    /* connection factory di questo filtro */
    private ConnectionFactory connectionFactory;

    /* ritardo massimo tra messaggi */
    private int maxDelay;

    /* il consumatore di questo filtro */
    private SimpleAsynchConsumer simpleConsumer;
    /* il produttore di questo filtro */
    private SimpleProducer simpleProducer;
    /* il filtro di messaggi per elaborare i messaggi */
    private SimpleMessageFilter messageFilter;

    /* numero di messaggi ricevuti finora */
    private int messagesReceived;
    /* e' stato cancellato? */
    private boolean cancelled;

    /*
	 * Crea un nuovo SimpleFilter di nome name
	 * che legge messaggi dalla destinazione sorgenteMessaggi
	 * e invia messaggi alla destinazione destinazioneMessaggi, 
	 * che inviera' i messaggi filtrati dal message filter mf.
	 */
	public SimpleFilter(String name, String sorgenteMessaggi, String destinazioneMessaggi,
			String connectionFactory, SimpleMessageFilter mf, int maxDelay) {
		this.name = name;
    	this.messageSource = (Destination) JndiUtil.getInstance().jndiLookup(sorgenteMessaggi);
    	this.messageDestination = (Destination) JndiUtil.getInstance().jndiLookup(destinazioneMessaggi);
    	this.connectionFactory = (ConnectionFactory) JndiUtil.getInstance().jndiLookup(connectionFactory);
    	this.messageFilter = mf;

    	this.maxDelay = maxDelay;

    	/* crea un consumatore su sorgenteMessaggi: 
    	 * girera' messaggi a questo oggetto (this) */
    	this.simpleConsumer =
    			new SimpleAsynchConsumer("Consumatore messaggi per " + this.name,
    					this.messageSource, this.connectionFactory, this, 10);
        logger.info("Creato consumatore: " + simpleConsumer.toString());

        /* crea un produttore su destinazioneMessaggi */
    	this.simpleProducer = new SimpleProducer("Produttore messaggi per " + this.name,
    			this.messageDestination, this.connectionFactory, 10);
        logger.info("Creato produttore: " + simpleProducer.toString());

        this.messagesReceived = 0;
        this.cancelled = false;
	}	
	
    /*
	 * Crea un nuovo SimpleFilter di nome name
	 * che legge messaggi dalla destinazione sorgenteMessaggi
	 * e invia messaggi alla destinazione destinazioneMessaggi, 
	 * che inviera' i messaggi filtrati dal message filter mf.
	 */
	public SimpleFilter(String name, Destination sorgenteMessaggi, Destination destinazioneMessaggi,
			ConnectionFactory connectionFactory, SimpleMessageFilter mf, int maxDelay) {
		this.name = name;
    	this.messageSource = sorgenteMessaggi;
    	this.messageDestination = destinazioneMessaggi;
    	this.connectionFactory = connectionFactory;
    	this.messageFilter = mf;

    	this.maxDelay = maxDelay;

    	/* crea un consumatore su sorgenteMessaggi: 
    	 * girera' messaggi a questo oggetto (this) */
    	this.simpleConsumer =
    			new SimpleAsynchConsumer("Consumatore messaggi per " + this.name,
    					this.messageSource, this.connectionFactory, this, 10);
        logger.info("Creato consumatore: " + simpleConsumer.toString());

        /* crea un produttore su destinazioneMessaggi */
    	this.simpleProducer = new SimpleProducer("Produttore messaggi per " + this.name,
    			this.messageDestination, this.connectionFactory, 10);
        logger.info("Creato produttore: " + simpleProducer.toString());

        this.messagesReceived = 0;
        this.cancelled = false;
	}

    /**
     * Apre le connessioni per le destinazioni JMS di questo filtro.
     */
    public void connect() {
        /* avvia il produttore */
        simpleProducer.connect();
        /* avvia il consumatore */
        simpleConsumer.connect();
    }

    /**
     * Si disconnette dalla destinazione JMS di questo consumer.
     */
    public void disconnect() {
        /* disconnette il consumatore */
        simpleConsumer.disconnect();
		/* disconnette il produttore */
		simpleProducer.disconnect();

		logger.info(this.toString() + ": Disconnected (" + messagesReceived + " message(s) received)");
    }

    /**
     * Inizia la sessione di ricezione di messaggi dalla destinazione.
     */
    public void filterMessages() {
    	this.simpleConsumer.receiveMessages();
    }

    /**
     * Riceve e filtra un messaggio
     * (implementa TextMessageProcessor).
     */
    public void processMessage(String inMessage) {
		logger.info("SimpleFilter: Ricevuto messaggio: " + inMessage);
		this.messagesReceived++;
		/* invia un messaggio alla destinazione */
		String outMessage = inMessage.toUpperCase() + " (filtered by " + name + ")";
        /* introduce un ritardo */
    	Sleeper.randomSleep(maxDelay/2,maxDelay);
		if (outMessage!=null) {
			logger.fine("SimpleFilter.processMessage(): sending " + outMessage);
			/* trasmette il nuovo messaggio alla destinazione successiva */
			simpleProducer.sendMessage(outMessage);
		}
    }

    /**
     * Cancella questo filtro.
     */
    public void cancel() {
    	this.cancelled = true;
    	/* cancella anche il suo consumatore */
    	this.simpleConsumer.cancel();
    }

    /**
     * Questo filtro e' stato cancellato?
     */
    public boolean isCancelled() {
    	return this.cancelled;
    }

    /**
     * Restituisce una descrizione di questo filtro.
     */
    public String toString() {
        return "SimpleFilter[" +
                "name=" + name +
                ", maxDelay=" + maxDelay +
//                ", reading from=" + messageSource.toString() +
//                ", writing to=" + messageDestination.toString() +
                "]";
    }

}
