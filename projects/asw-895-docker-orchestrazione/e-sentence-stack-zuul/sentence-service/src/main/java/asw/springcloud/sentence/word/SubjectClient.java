package asw.springcloud.sentence.word;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@FeignClient(name="subject", url="subject:8080")
public interface SubjectClient {

	@RequestMapping(value="/", method=RequestMethod.GET)
	public String getWord(); 

}
