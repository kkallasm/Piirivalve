// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ee.itcollege.jejee.web;

import ee.itcollege.jejee.entities.Intsident;
import ee.itcollege.jejee.entities.Objekt;
import ee.itcollege.jejee.entities.Objekt_intsidendis;
import java.io.UnsupportedEncodingException;
import java.lang.Integer;
import java.lang.Long;
import java.lang.String;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.joda.time.format.DateTimeFormat;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect Objekt_intsidendisController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST)
    public String Objekt_intsidendisController.create(@Valid Objekt_intsidendis objekt_intsidendis, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            uiModel.addAttribute("objekt_intsidendis", objekt_intsidendis);
            addDateTimeFormatPatterns(uiModel);
            return "objekt_intsidendises/create";
        }
        uiModel.asMap().clear();
        objekt_intsidendis.persist();
        return "redirect:/objekt_intsidendises/" + encodeUrlPathSegment(objekt_intsidendis.getObjekt_intsidendis_ID().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String Objekt_intsidendisController.createForm(Model uiModel) {
        uiModel.addAttribute("objekt_intsidendis", new Objekt_intsidendis());
        addDateTimeFormatPatterns(uiModel);
        List dependencies = new ArrayList();
        if (Intsident.countIntsidents() == 0) {
            dependencies.add(new String[]{"intsident", "intsidents"});
        }
        if (Objekt.countObjekts() == 0) {
            dependencies.add(new String[]{"objekt", "objekts"});
        }
        uiModel.addAttribute("dependencies", dependencies);
        return "objekt_intsidendises/create";
    }
    
    @RequestMapping(value = "/{objekt_intsidendis_ID}", method = RequestMethod.GET)
    public String Objekt_intsidendisController.show(@PathVariable("objekt_intsidendis_ID") Long objekt_intsidendis_ID, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("objekt_intsidendis", Objekt_intsidendis.findObjekt_intsidendis(objekt_intsidendis_ID));
        uiModel.addAttribute("itemId", objekt_intsidendis_ID);
        return "objekt_intsidendises/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String Objekt_intsidendisController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            uiModel.addAttribute("objekt_intsidendises", Objekt_intsidendis.findObjekt_intsidendisEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Objekt_intsidendis.countObjekt_intsidendises() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("objekt_intsidendises", Objekt_intsidendis.findAllObjekt_intsidendises());
        }
        addDateTimeFormatPatterns(uiModel);
        return "objekt_intsidendises/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String Objekt_intsidendisController.update(@Valid Objekt_intsidendis objekt_intsidendis, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            uiModel.addAttribute("objekt_intsidendis", objekt_intsidendis);
            addDateTimeFormatPatterns(uiModel);
            return "objekt_intsidendises/update";
        }
        uiModel.asMap().clear();
        objekt_intsidendis.merge();
        return "redirect:/objekt_intsidendises/" + encodeUrlPathSegment(objekt_intsidendis.getObjekt_intsidendis_ID().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{objekt_intsidendis_ID}", params = "form", method = RequestMethod.GET)
    public String Objekt_intsidendisController.updateForm(@PathVariable("objekt_intsidendis_ID") Long objekt_intsidendis_ID, Model uiModel) {
        uiModel.addAttribute("objekt_intsidendis", Objekt_intsidendis.findObjekt_intsidendis(objekt_intsidendis_ID));
        addDateTimeFormatPatterns(uiModel);
        return "objekt_intsidendises/update";
    }
    
    @RequestMapping(value = "/{objekt_intsidendis_ID}", method = RequestMethod.DELETE)
    public String Objekt_intsidendisController.delete(@PathVariable("objekt_intsidendis_ID") Long objekt_intsidendis_ID, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Objekt_intsidendis.findObjekt_intsidendis(objekt_intsidendis_ID).remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/objekt_intsidendises";
    }
    
    @ModelAttribute("intsidents")
    public Collection<Intsident> Objekt_intsidendisController.populateIntsidents() {
        return Intsident.findAllIntsidents();
    }
    
    @ModelAttribute("objekts")
    public Collection<Objekt> Objekt_intsidendisController.populateObjekts() {
        return Objekt.findAllObjekts();
    }
    
    @ModelAttribute("objekt_intsidendises")
    public Collection<Objekt_intsidendis> Objekt_intsidendisController.populateObjekt_intsidendises() {
        return Objekt_intsidendis.findAllObjekt_intsidendises();
    }
    
    void Objekt_intsidendisController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("objekt_intsidendis_avatud_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
        uiModel.addAttribute("objekt_intsidendis_muudetud_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
        uiModel.addAttribute("objekt_intsidendis_suletud_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
        uiModel.addAttribute("objekt_intsidendis_alates_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
        uiModel.addAttribute("objekt_intsidendis_kuni_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
    }
    
    String Objekt_intsidendisController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}