package com.Bar.blog.services;
import com.Bar.blog.models.Component;
import com.Bar.blog.models.Drink;
import com.Bar.blog.models.Image;
import com.Bar.blog.models.User;
import com.Bar.blog.repositories.ComponentRepository;
import com.Bar.blog.repositories.DrinkRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.io.IOException;

@Service
@Slf4j
@RequiredArgsConstructor
public class DrinkService {
    private final DrinkRepository drinkRepository;
    private final ComponentRepository componentRepository;
    private final ComponentService componentService;
    public int saveDrink(MultipartFile file, Drink drink, int[] lot) throws IOException {
        if (drinkRepository.findByTitle(drink.getTitle()) != null)
            return 1;
        if (file.getSize() != 0){
            Image image = toImageEntity(file);
            image.setDrink(drink);
            drink.setImage(image);
        }
        var items = componentService.listComponents(new User());
        for (int i =0;i < lot.length;i++) {
            if (lot[i] > 0)
                drink.addComponentToDrink(items.get(i), lot[i]);
        }
        if (drink.getComponents().isEmpty())
            return 2;
        drink.setAvailable(availableDrink(drink));
        drinkRepository.save(drink);
        log.info("Saving new Drink.");
        return 0;
    }
    public boolean availableDrink(Drink drink) {
        var map = drink.getComponents();
        var items = componentService.listComponents(new User());
        for (var entry : map.entrySet())
            if (items.get(items.indexOf(entry.getKey())).getCount() < entry.getValue())
                return false;
        return true;
    }
    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }
    public boolean editDrink(String title,int[] lot){
        var drink = getDrinkByTitle(title);
        List<Component> items = new ArrayList<>(drink.getComponents().keySet());
        List<Component> list = new ArrayList<>(componentService.listComponents(new User()));
        list.removeAll(items);
        items.addAll(list);
        drink.getComponents().clear();
        for (int i =0;i < lot.length;i++)
            if (lot[i] > 0)
                drink.addComponentToDrink(items.get(i), lot[i]);
        if (drink.getComponents().isEmpty())
            return false;
        drink.setAvailable(availableDrink(drink));
        drinkRepository.save(drink);
        log.info("Edit Drink.");
        return true;
    }
    public void buyDrink(String title){
        var thisDrink = getDrinkByTitle(title);
        var map = thisDrink.getComponents();
        var items = componentService.listComponents(new User());
        for (var entry : map.entrySet()) {
            var item = items.get(items.indexOf(entry.getKey()));
            item.setCount(item.getCount() - entry.getValue());
            componentRepository.save(item);
        }
        var drinks = drinkRepository.findAll();
        for (var drink : drinks)
            drink.setAvailable(availableDrink(drink));
        drinkRepository.saveAll(drinks);
        log.info("Buy Drink.");
    }
    public List<Drink> listDrink(User user) {
        if (user.isProvider() || user.isVisitor())
            return drinkRepository.findByAvailable(true);
        else
            return drinkRepository.findAll();
    }
    public void deleteDrink(String title){
        drinkRepository.deleteByTitle(title);
    }
    public Drink getDrinkByTitle(String title){
        return drinkRepository.findByTitle(title);
    }
}