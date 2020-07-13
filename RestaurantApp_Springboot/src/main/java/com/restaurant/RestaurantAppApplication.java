package com.restaurant;

import java.util.Collection;
import java.util.List;
import java.util.Random;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.restaurant.dao.CategorieRepository;
import com.restaurant.dao.RestaurantRepository;
import com.restaurant.entities.Categorie;
import com.restaurant.entities.Restaurant;

@SpringBootApplication
public class RestaurantAppApplication implements CommandLineRunner {
	
	@Autowired
	CategorieRepository categorieRepository;
	@Autowired
	RestaurantRepository restaurantRepository;
	int i=0;
	public static void main(String[] args) {
		SpringApplication.run(RestaurantAppApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		
		Categorie c1=categorieRepository.save(new Categorie(1,"Maroccain", null));
		Categorie c2=categorieRepository.save(new Categorie(2,"Francais", null));
		Categorie c3=categorieRepository.save(new Categorie(3,"Chinoise", null));
		Categorie c4=categorieRepository.save(new Categorie(4,"Italian", null));
		Categorie c5=categorieRepository.save(new Categorie(5,"categ5", null));
		Categorie c6=categorieRepository.save(new Categorie(6,"categ6", null));
		
		List<Categorie> categories = categorieRepository.findAll();
		for(i=0;i<categories.size();i++) {
			Stream.of("Alan Restaurant",  "Lander", "Best Food", "Ranpok Restaurant")
			.forEach(restaurantName -> {
				Restaurant restauurant = new Restaurant();
				restauurant.setName(restaurantName);
				restauurant.setAdresse("Mokawama 7 Casablanca");
				restauurant.setDescription("welcome to our awsome restaurant");
				restauurant.setPhone("0654879321");
				restauurant.setPhoto(restaurantName.replaceAll(" ", "") + ".jpg");
				restauurant.setCategorie(categories.get(i));
				restauurant.setLongitude(33.533131);
				restauurant.setLatitude( -7.608246);
				restaurantRepository.save(restauurant);
			});
		}
		

//		Restaurant r1=restaurantRepository.save(new Restaurant(null, "test", "adresse", "desc", "phone", "test.jpg", 1245, 125.2, c1));
//		Restaurant r2=restaurantRepository.save(new Restaurant(null, "test1", "adresse", "desc", "phone", "test1.jpg", 1245, 125.2, c1));
//		Restaurant r3=restaurantRepository.save(new Restaurant(null, "test2", "adresse", "desc", "phone", "test2.jpg", 1245, 125.2, c1));
//		Restaurant r4=restaurantRepository.save(new Restaurant(null, "test3", "adresse", "desc", "phone", "test3.jpg", 1245, 125.2, c1));
//		Restaurant r5=restaurantRepository.save(new Restaurant(null, "test4", "adresse", "desc", "phone", "photo", 1245, 125.2, c1));
//		Restaurant r6=restaurantRepository.save(new Restaurant(null, "test4", "adresse", "desc", "phone", "photo", 1245, 125.2, c2));

		//System.out.println(s);
	}

}
