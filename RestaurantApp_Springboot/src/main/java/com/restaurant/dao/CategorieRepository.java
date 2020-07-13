package com.restaurant.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.web.bind.annotation.CrossOrigin;

import com.restaurant.entities.Categorie;

@RepositoryRestController
@CrossOrigin("*")
public interface CategorieRepository extends JpaRepository<Categorie, Integer>{
public Categorie findByName(String c);
}