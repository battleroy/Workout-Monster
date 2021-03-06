package by.bsu.fpmi.battleroy.controllers;

import by.bsu.fpmi.battleroy.model.User;
import by.bsu.fpmi.battleroy.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
public class SignupController {

    @Autowired
    @Qualifier("authenticationManager")
    private AuthenticationManager authManager;

    @Autowired
    private UserService userService;

    @RequestMapping(value = { "/signup" }, method = RequestMethod.GET)
    public ModelAndView getSignup() {
        ModelAndView modelAndView = new ModelAndView("../../WEB-INF/views/signup");
        modelAndView.addObject("user", new User());
        return modelAndView;
    }

    @RequestMapping(value = { "/register" }, method = RequestMethod.POST)
    public ModelAndView registerUser(@ModelAttribute("user") User newUser, BindingResult result, Errors errors, HttpServletRequest request) {
        User registered = new User();
        if (!result.hasErrors()) {
            registered = createUserAccount(newUser, result);
        }
        if (registered == null || result.hasErrors()) {
            return new ModelAndView("../../WEB-INF/views/signup", "error", "Error");
        }

        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(registered.getUsername(), newUser.getPassword());
        token.setDetails(new WebAuthenticationDetails(request));
        Authentication authentication = authManager.authenticate(token);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        request.getSession().setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());
        request.getSession().setAttribute("user", registered);

        return new ModelAndView("../../index");
    }

    private User createUserAccount(User newUser, BindingResult result) {
        User registered = null;
        try {
            registered = userService.registerNewUserAccount(newUser);
        } catch (NullPointerException e) {
            return null;
        }
        return registered;
    }

}
