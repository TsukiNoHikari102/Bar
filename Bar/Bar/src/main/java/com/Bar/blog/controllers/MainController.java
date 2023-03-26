package com.Bar.blog.controllers;
import com.Bar.blog.models.Drink;
import com.Bar.blog.models.User;
import com.Bar.blog.models.enums.Role;
import com.Bar.blog.services.ComponentService;
import com.Bar.blog.services.DrinkService;
import com.Bar.blog.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
@Controller
@RequiredArgsConstructor
public class MainController {
    private final ComponentService componentService;
    private final DrinkService drinkService;
    private final UserService userService;
    @GetMapping("/")
    public String index(Principal principal, Model model) {
        var user = userService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        model.addAttribute("drinks", drinkService.listDrink(user));
        return "index";
    }
    @PostMapping("/delete/{title}")
    public String indexDelete(@PathVariable String title) {
        drinkService.deleteDrink(title);
        return "redirect:/";
    }
    @GetMapping("/edit/{title}")
    public String indexEdit(@PathVariable String title, Principal principal, Model model) {
        var user = userService.getUserByPrincipal(principal);
        var drink = drinkService.getDrinkByTitle(title);
        var items = componentService.listComponents(user);
        items.removeAll(drink.getComponents().keySet());
        model.addAttribute("drink", drink);
        model.addAttribute("items", items);
        model.addAttribute("user", user);
        return "edit";
    }
    @PostMapping("/edit/{title}")
    public String drinkEdit(@PathVariable String title,@RequestParam("lot") int[] lot, Principal principal, Model model) {
        if (drinkService.editDrink(title, lot)){
            return "redirect:/";
        }
        model.addAttribute("errorMessage", "Напиток без ингридиентов");
        return indexEdit(title, principal, model);
    }
    @PostMapping("/buy/{title}")
    public String buyProduct(@PathVariable String title) {
        drinkService.buyDrink(title);
        return "redirect:/";
    }
    @GetMapping("/warehouse")
    public String warehouse(Principal principal, Model model) {
        var user = userService.getUserByPrincipal(principal);
        model.addAttribute("items", componentService.listComponents(user));
        model.addAttribute("user", user);
        return "warehouse";
    }
    @PostMapping("/warehouse")
    public String warehouseNew(Principal principal,@RequestParam("title") String title, Model model) {
        if (componentService.saveComponent(title)){
            return "redirect:/warehouse";
        }
        model.addAttribute("errorMessage", "Ингридиент " + title + " уже существует");
        return warehouse(principal, model);
    }
    @PostMapping("/warehouse/delivery/{title}")
    public String warehouseDelivery(@PathVariable String title, @RequestParam("count") int count) {
        componentService.deliveryComponent(title, count);
        return "redirect:/warehouse";
    }
    @PostMapping("/warehouse/request/{title}")
    public String warehouseRequest(@PathVariable String title) {
        componentService.requestComponent(title);
        return "redirect:/warehouse";
    }
    @GetMapping("/add")
    public String add(Principal principal,Model model) {
        var user = userService.getUserByPrincipal(principal);
        model.addAttribute("items", componentService.listComponents(user));
        model.addAttribute("user", user);
        return "add";
    }
    @PostMapping("/add")
    public String addDrink(@RequestParam("file") MultipartFile file, Drink drink, @RequestParam("lot") int[] lot, Principal principal, Model model) throws IOException {
        var code = drinkService.saveDrink(file, drink, lot);
        if (code == 0){
            return "redirect:/add";
        }
        else if (code == 1)
            model.addAttribute("errorMessage", "Напиток " + drink.getTitle() + " уже существует");
        else
            model.addAttribute("errorMessage", "Напиток без ингридиентов");
        return add(principal, model);
    }
    @GetMapping("/admin")
    public String admin(Principal principal, Model model) {
        model.addAttribute("users", userService.list());
        return "admin";
    }
    @GetMapping("/admin/edit_role/{user}")
    public String userEdit(@PathVariable("user") User user, Model model) {
        Role[] roles = {Role.ROLE_BARMEN, Role.ROLE_PROVIDER, Role.ROLE_VISITOR};
        model.addAttribute("user", user);
        model.addAttribute("roles", roles);
        return "edit_role";
    }
    @PostMapping("/admin/edit_role")
    public String userEdit(@RequestParam("userId") User user, @RequestParam Map<String, String> form) {
        userService.changeUserRoles(user, form);
        return "redirect:/admin";
    }
    @PostMapping("/admin/delete/{id}")
    public String userDelete(@PathVariable("id") Long id) {
        userService.deleteUser(id);
        return "redirect:/admin";
    }
    @GetMapping("/about")
    public String about(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "about";
    }
}