package asw.springcloud.sentence;

import asw.springcloud.sentence.word.WordClient;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.logging.Logger; 

@RestController
public class SentenceController {

	private final Logger logger = Logger.getLogger("asw.springcloud.sentence"); 

	@Autowired 
	private WordClient wordClient;

	@RequestMapping("/sentence")
	public String getSentence() {
		String sentence =  
			wordClient.getWord("subject") + " " + 
			wordClient.getWord("verb") + " " + 
			wordClient.getWord("object") + ".";
		logger.info("getSentence(): " + sentence);
		return sentence; 
	}
	
}
