package com.Bar.blog.services;

import com.Bar.blog.models.Component;
import com.Bar.blog.models.Drink;
import com.Bar.blog.models.User;
import com.Bar.blog.repositories.ComponentRepository;
import com.Bar.blog.repositories.DrinkRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import java.util.List;


@Service
@Slf4j
@RequiredArgsConstructor
public class ComponentService {
    private final ComponentRepository componentRepository;
    private final DrinkRepository drinkRepository;
    public boolean saveComponent(String title) {
        if (componentRepository.findByTitle(title) != null){
            return false;
        }
        componentRepository.save(new Component(title));
        log.info("Saving new Component.");
        return true;
    }
    public List<Component> listComponents(User user) {
        List<Component> list;
        if (user.isProvider()) list = componentRepository.findByRequest(true);
        else list = componentRepository.findAll();
        if (list.isEmpty()) return null;
        return list;
    }
    public void requestComponent(String title) {
        var component = componentRepository.findByTitle(title);
        component.setRequest(true);
        componentRepository.save(component);
        log.info("Request Component {}.", title);
    }
    public void deliveryComponent(String title, int count) {
        var component = componentRepository.findByTitle(title);
        component.setRequest(false);
        component.setCount(component.getCount()+count);
        componentRepository.save(component);
        var drinks = drinkRepository.findAll();
        for (var drink : drinks) {
            var map = drink.getComponents();
            if (map.containsKey(component)) {
                drink.setAvailable(availableDrink(drink));
                drinkRepository.save(drink);
            }
        }
        log.info("Delivery Component {}.", title);
    }
    private boolean availableDrink(Drink drink) {
        var map = drink.getComponents();
        var items = listComponents(new User());
        for (var entry : map.entrySet())
            if (items.get(items.indexOf(entry.getKey())).getCount() < entry.getValue())
                return false;
        return true;
    }
}
