package ee.itcollege.jejee.web;

import ee.itcollege.jejee.entities.Piiripunkt;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RooWebScaffold(path = "piiripunkts", formBackingObject = Piiripunkt.class)
@RequestMapping("/piiripunkts")
@Controller
public class PiiripunktController {
}
