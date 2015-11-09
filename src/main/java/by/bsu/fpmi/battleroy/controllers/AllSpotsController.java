package by.bsu.fpmi.battleroy.controllers;

import by.bsu.fpmi.battleroy.model.Spot;
import by.bsu.fpmi.battleroy.model.User;
import by.bsu.fpmi.battleroy.services.PhotoService;
import by.bsu.fpmi.battleroy.services.SpotService;
import by.bsu.fpmi.battleroy.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@Controller
public class AllSpotsController {

    @Autowired
    SpotService spotService;

    @Autowired
    UserService userService;

    @Autowired
    PhotoService photoService;

    @RequestMapping(value = { "/" }, method = RequestMethod.GET)
    public ModelAndView getIndex() {
        ModelAndView modelAndView = new ModelAndView("../../index");
        modelAndView.addObject("spots", spotService.getAllSpots());
        return modelAndView;
    }

    @RequestMapping(value = { "/myspots" }, method = RequestMethod.GET)
    public ModelAndView getMySpots(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("../../index");
        User user = (User)request.getSession().getAttribute("user");
        Set<Spot> userSpots = spotService.getSpotsByUserId(user.getUsername());
        modelAndView.addObject("spots", userSpots);
        modelAndView.addObject("photos", getPhotoLinksForSpots(userSpots));
        return modelAndView;
    }

    @RequestMapping(value = { "/spot/{spotId}/delete" }, method = RequestMethod.POST)
    public String deleteSpotById(@PathVariable String spotId) {
        spotService.deleteSpotById(Long.parseLong(spotId));
        return "redirect:/myspots";
    }

    private Map<Spot, String> getPhotoLinksForSpots(Set<Spot> spots) {
        Map<Spot, String> photoMap = new HashMap<Spot, String>();
        for (Spot spot : spots) {
            try {
                long photoId = photoService.getPhotosForSpot(spot.getId()).get(0).getId();
                photoMap.put(spot, "/photo/" + photoId);
            } catch (IndexOutOfBoundsException ex) {
                photoMap.put(spot, "https://browshot.com/static/images/not-found.png");
            }
        }
        return photoMap;
    }

}