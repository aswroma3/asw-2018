package asw.rest.productmanager.client;

import asw.rest.productmanager.Product;

import java.util.*;

import java.util.logging.*;

/*
 * Client per il web service REST product-manager.
 * Normalmente opera in sola lettura. 
 * Per eseguire anche le operazioni in scrittura, usare il parametro aggiuntivo RW
 */

public class Main {

	/* proxy al servizio rest */
	private ProductManagerClient service;

	/* logger */
	private static Logger logger = Logger.getLogger("asw.rest.productmanager.client");

	public static void main(String[] args) {
		Main main = new Main();
		main.runReadOnlyOperations();
		/* esegue le operazioni di lettura/scrittura solo se è stato usato anche un parametro aggiuntivo uguale a RW */ 
		main.runModifyingOperations( args.length>0 && "RW".equals(args[0]) );
	}

	public Main() {
		/* crea il client (adapter) per il servizio rest */
		service = new ProductManagerClient();
	}

	private void runReadOnlyOperations() {
		Product product;
		Collection<Product> products;
		String result;
		boolean esito;

	   	/* usa il servizio rest Product Manager Service */
	   	logger.info("Client: Ora uso il servizio REST ProductManagerService");
	   	logger.info("Client: Esecuzione di operazioni in sola lettura");

	   	logger.info("");
	   	logger.info("Client: getProductAsJson(1)");
		product = service.getProductAsJson(1);
	   	logger.info("Client: --> " + product.toString());

	   	logger.info("");
	   	logger.info("Client: getProductAsXML(3)");
		product = service.getProductAsXML(3);
	   	logger.info("Client: --> " + product.toString());

	 	logger.info("");
	   	logger.info("Client: getProductsAsJsonString");
		result = service.getProductsAsJsonString();
	   	logger.info("Client: --> " + result);

	 	logger.info("");
	   	logger.info("Client: getProductsAsXMLString");
		result = service.getProductsAsXMLString();
	   	logger.info("Client: --> " + result);

	 	logger.info("");
	   	logger.info("Client: getProductsAsJson");
		products = service.getProductsAsJson();
	   	logger.info("Client: --> " + products.toString());

	   	logger.info("");
	   	logger.info("Client: getProductsAsXML");
		products = service.getProductsAsXML();
	   	logger.info("Client: --> " + products.toString());
	}

	/* esegue le operazioni di lettura scrittura solo se leggeScrive */ 
	private void runModifyingOperations(boolean leggeScrive) {
		
		if (!leggeScrive) {
			logger.info("Client: Per eseguire anche le operazioni di lettura/scrittura, usa anche il parametro aggiuntivo RW");
			return; 
		}
		
		Product product;
		Collection<Product> products;
		String result;
		boolean esito;

	   	logger.info("Client: Esecuzione di operazioni di lettura/scrittura");

	   	logger.info("");
	   	logger.info("Client: createProduct(16, \"NUOVO PRODOTTO FORM 16\", 160)");
		esito = service.createProduct(16, "NUOVO PRODOTTO FORM 16", 160);
	   	logger.info("Client: --> " + toString(esito));

	   	logger.info("");
	   	product = new Product(43, "NUOVO PRODOTTO JSON 43", 444);
	   	logger.info("Client: createProduct(" + product.toString() + ")");
		esito = service.createProduct(product);
	   	logger.info("Client: --> " + toString(esito));

	   	logger.info("");
	   	logger.info("Client: deleteProduct(5)");
		esito = service.deleteProduct(5);
	   	logger.info("Client: --> " + toString(esito));

	   	logger.info("");
	   	product = new Product(9, "PRODOTTO 9 MODIFICATO", 999);
	   	logger.info("Client: updateProduct(" + product.toString() + ")");
		esito = service.updateProduct(product);
	   	logger.info("Client: --> " + toString(esito));

		service.close();
	}

	private static String toString(boolean esito) {
		if (esito) {
			return "OK";
		} else {
			return "ERROR";
		}
	}

}
