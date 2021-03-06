package com.fuhe.jobcloud.action;

import java.io.File;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.security.Principal;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.Term;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.search.comm.ResultModel;
import com.search.comm.StringUtil;
import com.search.db.model.Job;
import com.search.db.model.vo.JobVO;
import com.search.form.model.SearchForm;
import com.search.lucence.IndexSearch;
import com.search.lucence.SuggestSupport;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private IndexSearch indexSearch;

	@Autowired
	private SuggestSupport suggestSupport;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! the client locale is "+ locale.toString());
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}

	@RequestMapping(value = "/demo1")//, params = "format=json"
	public ResponseEntity<String> demo1(@RequestParam(value = "callback", required = false) String callback, Principal principal) {
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Content-Type", "application/json");
		Object out="23232323232";
		return new ResponseEntity<String>(out.toString(), headers, HttpStatus.OK);
	}
	@RequestMapping(value = "/jobs")
	public String doSearch(Locale locale, Model model,SearchForm from,
			@RequestParam(value = "pageIndex", required = false) Integer pageIndex,
			@RequestParam(value = "pageSize", required = false) Integer pageSize,
			@CookieValue(value = "cookie_words", defaultValue = "") String wordsCookie,
			HttpServletResponse response){
		
		//HashMap<String, String> map=new HashMap<String,String>();
		
		if(pageIndex==null)pageIndex=1;
		if(pageSize==null)pageSize=10;
		
		try {
			//map.put("keyword", from.getKeyword());
			
			ResultModel<JobVO> result=indexSearch.doSearch(from,pageIndex,pageSize);
			
			String words[]=suggestSupport.doWork(from.getKeyword());
			
			model.addAttribute("form",from);
			model.addAttribute("result",result);
			
			model.addAttribute("words",words);
			
			//公司 group
			HashMap<String, Integer> companyMap=indexSearch.group("companyName", from.getKeyword());
			model.addAttribute("companyMap",companyMap);
			//salary group
			HashMap<String, Integer> salaryMap=indexSearch.group("salary", from.getKeyword());
			model.addAttribute("salaryMap",salaryMap);
			
			String words_search[]=wordsCookie.split("#");
			if(!StringUtil.isIn(from.getKeyword(), words_search)){
				
				wordsCookie+=from.getKeyword()+"#";
			}
			
			model.addAttribute("words_cookie",words_search);
			
			Cookie foo = new Cookie("cookie_words", URLEncoder.encode(wordsCookie, "UTF-8") ); 
			foo.setMaxAge(60*60*24*10); //10天
			response.addCookie(foo); 
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return "jobs";
	}

	@RequestMapping(value = "/suggest")
	public  ResponseEntity<String[]> suggest(@RequestParam(value = "q", required = false) String keyword, Principal principal) {
		
		HttpHeaders headers = new HttpHeaders();
		
		String words[]=suggestSupport.doWork(keyword);
		 
		return new ResponseEntity<String[]>(words, headers, HttpStatus.OK);
	}
	
	public IndexSearch getIndexSearch() {
		return indexSearch;
	}
	
	public void setIndexSearch(IndexSearch indexSearch) {
		this.indexSearch = indexSearch;
	}
		
}
