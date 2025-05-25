package com.pushkar.GemAI.repo;


import com.pushkar.GemAI.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByCategoryAndPriceLessThan(String category, double price);
}
