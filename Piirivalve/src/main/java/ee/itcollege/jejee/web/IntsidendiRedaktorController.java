package ee.itcollege.jejee.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ee.itcollege.jejee.entities.Intsident;
import ee.itcollege.jejee.entities.Objekt;
import ee.itcollege.jejee.entities.Piiririkkuja;
import ee.itcollege.jejee.entities.Piirivalvur;
import ee.itcollege.jejee.entities.Piirivalvur_intsidendis;
import ee.itcollege.jejee.entities.Vahtkond;


@RequestMapping("/intsident")
@Controller
public class IntsidendiRedaktorController {

	@PersistenceContext
	EntityManager entityManager;
	
	@Autowired
    private RedaktorValidation redaktorValidation;

    public void setRedaktorValidation(RedaktorValidation redaktorValidation) {
    	this.redaktorValidation = redaktorValidation;
    }
	
	@RequestMapping(value = "/{intsident_ID}", method = RequestMethod.GET)
    public String show(@PathVariable("intsident_ID") Long intsident_ID, Model uiModel) {
    	Intsident ints = Intsident.findIntsident(intsident_ID);
    	
    	Collection<Objekt> objektid = Objekt.findAllObjektidForIntsident(ints);
    	Collection<Piiririkkuja> isikud = Piiririkkuja.findAllPiiririkkujadForIntsident(ints);
    	Collection<Vahtkond> vahtkonnad = Vahtkond.findAllVahtkonnadForIntsident(ints);
    	Collection<Piirivalvur> piirivalvurid = Piirivalvur.findAllPiirivalvuridForIntsident(ints);
    	
        uiModel.addAttribute("intsident", ints);
        uiModel.addAttribute("objektid", objektid);
        uiModel.addAttribute("isikud", isikud);
        uiModel.addAttribute("vahtkonnad", vahtkonnad);
        uiModel.addAttribute("piirivalvurid", piirivalvurid);
        return "intsidendi_redaktor/view";
    }
	
	
	@RequestMapping(value = "/{intsident_ID}/lisa_piirivalvur", method = RequestMethod.GET)
    public String lisaPiirivalvur(@PathVariable("intsident_ID") Long intsident_ID, Model uiModel) {
		Intsident ints = Intsident.findIntsident(intsident_ID);
    	Collection<Piirivalvur> piirivalvurid = Piirivalvur.findAllPiirivalvuridNotInIntsident(ints);
    	Piirivalvur_intsidendis pi = new Piirivalvur_intsidendis();
    	
    	uiModel.addAttribute("piirivalvur_intsidendis", pi);
    	uiModel.addAttribute("id", intsident_ID);
        uiModel.addAttribute("piirivalvurid", piirivalvurid);
        uiModel.addAttribute("dateFormat", "yyyy-MM-dd");
        return "intsidendi_redaktor/add_piirivalvur";
    }
	
	
	@RequestMapping (value = "/{intsident_ID}/lisa_piirivalvur", method = RequestMethod.POST)
	public String submitCB(Model uiModel, @PathVariable("intsident_ID") Long intsident_ID, Piirivalvur_intsidendis pi, BindingResult result, 
			@RequestParam(value="ids", required=false) String[] ids) throws CloneNotSupportedException {
		
		redaktorValidation.validate(pi, result);
        if (result.hasErrors()) {
    		Intsident ints = Intsident.findIntsident(intsident_ID);
        	Collection<Piirivalvur> piirivalvurid = Piirivalvur.findAllPiirivalvuridNotInIntsident(ints);
        	
        	Collection<String> checked = new ArrayList<String>(piirivalvurid.size());
        	for (Piirivalvur piirivalvur : piirivalvurid) {
        		if(ids != null && Arrays.binarySearch(ids, Long.toString(piirivalvur.getId())) >= 0) {
        			checked.add("checked = \"checked\"");
                }
        		else {
        			checked.add("bla");
				}
			}

        	uiModel.addAttribute("id", intsident_ID);
            uiModel.addAttribute("piirivalvurid", piirivalvurid);
            uiModel.addAttribute("dateFormat", "yyyy-MM-dd");
            uiModel.addAttribute("checks", checked);
            
        	return "intsidendi_redaktor/add_piirivalvur";        	
        }
		
		if(ids != null) {
			Intsident ints = Intsident.findIntsident(intsident_ID);
			if(ints != null) {
				Piirivalvur_intsidendis tmp = (Piirivalvur_intsidendis) pi.clone();
				for (int i = 0; i < ids.length; i++) {
					Piirivalvur piirivalvur = Piirivalvur.findPiirivalvur(Long.parseLong(ids[i]));
					tmp.setIntsident(ints);
					tmp.setPiirivalvur(piirivalvur);
					tmp.setAvaja("Fedja");	//TODO
					tmp.setMuutja("Fedja");	//TODO
				}
				tmp.persist();
			}
		}
		
	    return "redirect:/intsident/" + intsident_ID;
	}


}

