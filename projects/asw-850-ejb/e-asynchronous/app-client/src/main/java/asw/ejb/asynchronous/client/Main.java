package asw.ejb.asynchronous.client;

import asw.ejb.asynchronous.*;

import javax.ejb.EJB;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.logging.Logger;

/*
 * Application client per l'EJB AsynchronousHello.
 */

public class Main {

	@EJB(lookup = "ejb/asw/AsynchronousHello")
	private static AsynchronousHello asyncHello;

	/* logger */
	private static Logger logger = Logger.getLogger("asw.ejb.asynchronous.client");

	public static void main(String[] args) {
		new Main() . run();
	}

	public Main() {
	}

	private void run() {
    	/* usa il servizio AsynchronousHello */
    	logger.info("Client: Ora uso il servizio AsynchronousHello");

    	/* dovrebbe restituire "Hello, LUCA!" */
    	callAsyncHello("Luca");

    	/* l'operazione dovrebbe venire cancellata */
    	callAsyncHello("Benedetta");

    	/* dovrebbe sollevare un'eccezione di business */
    	callAsyncHello(null);

    	logger.info("Client: Ho finito di usare il servizio AsynchronousHello");
	}

    /* chiama l'operazione asincrona */
    private void callAsyncHello(String param) {
    	/* usa il servizio AsynchronousHello */
		logger.info("Client: calling AsynchronousHello.hello(" + param + ")");
		Future<String> futureResult;
		long startingTime = System.currentTimeMillis();
		try {
			futureResult = asyncHello.hello(param);
			/* aspetta, ma al massimo un paio di secondi, facendo altre cose */
			for (int i=0; i<10; i++) {
				long currentTime = System.currentTimeMillis();
				logger.info("Client: AsynchronousHello.hello(" + param + "): " +
						"in attesa da " + (currentTime-startingTime) + " ms)");
				sleep(250);
				if (futureResult.isDone()) {
					break;
				}
			}
			/* se non ha ancora finito, annulla l'operazione */
			if (!futureResult.isDone()) {
				logger.info("Client: AsynchronousHello.hello(" + param + "): cancellazione");
				futureResult.cancel(true);
			}
			/* attende ancora la terminazione */
			while (true) {
				long currentTime = System.currentTimeMillis();
				logger.info("Client: AsynchronousHello.hello(" + param + ") annullata: " +
						"in attesa da " + (currentTime-startingTime) + " ms)");
				sleep(250);
				if (futureResult.isDone() || futureResult.isCancelled()) {
					break;
				}
			}
			if (futureResult.isCancelled()) {
				long endingTime = System.currentTimeMillis();
				logger.info("Client: AsynchronousHello.hello(" + param + ") ==> was canceled" +
						" (" + (endingTime-startingTime) + " ms)");
			} else {
				String result = futureResult.get();
				long endingTime = System.currentTimeMillis();
				logger.info("Client: AsynchronousHello.hello(" + param + ") ==> " + result +
							" (" + (endingTime-startingTime) + " ms)");
			}
		} catch (HelloException | InterruptedException | ExecutionException e) {
//			e.printStackTrace();
			logger.info("Client: AsynchronousHello.hello(" + param + ") ha sollevato un'eccezione: " + e.getMessage());
		}
    }

	/* Introduce un ritardo di esattamente delay millisecondi. */
	private static void sleep(int delay) {
        try {
        	// int delay = (int)(Math.random()*maxDelay);
            Thread.sleep(delay);
        } catch (InterruptedException e) {}
	}		
		
}