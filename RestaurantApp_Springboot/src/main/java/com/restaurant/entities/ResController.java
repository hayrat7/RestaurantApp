package com.restaurant.entities;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.restaurant.dao.CategorieRepository;
import com.restaurant.dao.RestaurantRepository;

@RestController
@CrossOrigin("*")
public class ResController {
	@Autowired
	private RestaurantRepository restRepo;
	@Autowired
	CategorieRepository categR;
	@GetMapping(path = "/resName")
	public List<Restaurant> test(@RequestParam(name = "cat") String c) {
		List<Restaurant> s= restRepo.findByCategorieNameContains(c);
		return s;
	}
	@GetMapping(path = "/categoryByName")
	public Categorie test1(@RequestParam(name = "name") String t) {
		Categorie c= categR.findByName(t);
		return c;
	}
	
	@GetMapping(path = "/restaurantById")
	public Optional<Restaurant> test2(@RequestParam(name = "id") Long t) {
		Optional<Restaurant> c= restRepo.findById(t);
		return c;
	}
	@GetMapping(path = "/restaurantByName")
	public List<Restaurant> test3(@RequestParam(name = "name") String t) {
		List<Restaurant> s= restRepo.findByNameContains(t);
		return s;
	}
	@PostMapping("/addRestaurant")
	@Transactional
	public Restaurant addRestaurant(@RequestParam(name = "name") String name,
			@RequestParam(name = "adresse") String adresse,
			@RequestParam(name = "desc") String desc,
			@RequestParam(name = "phone") String phone,
			@RequestParam(name = "photo") String photo,
			@RequestParam(name = "lon") double lon,
			@RequestParam(name = "lat") double lat,
			@RequestParam(name = "cat") String cat
			) {
		Categorie c=categR.findByName(cat);
		Restaurant restaurant =new Restaurant(null, name, adresse, desc, phone, photo, lon, lat, c);
		restaurant.setPhoto(photo.replaceAll(" ", "") + ".jpg");
		restRepo.save(restaurant);
		return restaurant;
	}
	
	@GetMapping(path ="/imageFilm/{id}",produces = MediaType.IMAGE_JPEG_VALUE)
	public byte[] image(@PathVariable(name = "id")Long id) throws Exception{
		Restaurant s=restRepo.findById(id).get();
		String photoName=s.getPhoto();
		File file=new File(System.getProperty("user.home")+"/restaurant/images/"+photoName);
		Path path=Paths.get(file.toURI());
		return Files.readAllBytes(path);
	}
}

