package com.restaurant.dao;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;

import com.restaurant.entities.Categorie;
import com.restaurant.entities.Restaurant;

@RepositoryRestResource
@CrossOrigin("*")
public interface RestaurantRepository extends JpaRepository<Restaurant, Long>{
	public List<Restaurant> findByNameContains(String c);
	public List<Restaurant> findByCategorieNameContains(String c);
	public List<Restaurant> findByCategorie(Categorie c);
	
}