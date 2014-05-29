package com.fuhe.jobcloud.action;

import java.io.File;
import java.security.Principal;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

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
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fuhe.model.form.SearchForm;
import com.search.comm.ResultModel;
import com.search.db.model.Job;
import com.search.lucence.IndexSearch;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

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
			@RequestParam(value = "pageSize", required = false) Integer pageSize){
		
		HashMap<String, String> map=new HashMap<String,String>();
		
		if(pageIndex==null)pageIndex=1;
		if(pageSize==null)pageSize=3;
		
		try {
			
			IndexSearch indexSearch=new IndexSearch();
			indexSearch.setIndexDir("/Users/fuhe-apple-02/temp/index");
			
			map.put("keyword", from.getKeyword());
			
			ResultModel<Job> result=indexSearch.doSearch(map,pageIndex,pageSize);
			
			model.addAttribute("pageCount", result.getPageCount());
			model.addAttribute("list", result.getList());
			model.addAttribute("form",from);
			
			model.addAttribute("result",result);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return "jobs";
	}
		
}