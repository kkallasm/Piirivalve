// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ee.itcollege.jejee.entities;

import ee.itcollege.jejee.entities.Piiririkkuja;
import java.lang.Integer;
import java.lang.Long;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Version;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Piiririkkuja_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager Piiririkkuja.entityManager;
    
    @Version
    @Column(name = "version")
    private Integer Piiririkkuja.version;
    
    public Integer Piiririkkuja.getVersion() {
        return this.version;
    }
    
    public void Piiririkkuja.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Piiririkkuja.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Piiririkkuja.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Piiririkkuja attached = Piiririkkuja.findPiiririkkuja(this.piiririkkuja_ID);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Piiririkkuja.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Piiririkkuja.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public Piiririkkuja Piiririkkuja.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Piiririkkuja merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
    public static final EntityManager Piiririkkuja.entityManager() {
        EntityManager em = new Piiririkkuja().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Piiririkkuja.countPiiririkkujas() {
        return entityManager().createQuery("SELECT COUNT(o) FROM Piiririkkuja o", Long.class).getSingleResult();
    }
    
    public static List<Piiririkkuja> Piiririkkuja.findAllPiiririkkujas() {
        return entityManager().createQuery("SELECT o FROM Piiririkkuja o", Piiririkkuja.class).getResultList();
    }
    
    public static Piiririkkuja Piiririkkuja.findPiiririkkuja(Long piiririkkuja_ID) {
        if (piiririkkuja_ID == null) return null;
        return entityManager().find(Piiririkkuja.class, piiririkkuja_ID);
    }
    
    public static List<Piiririkkuja> Piiririkkuja.findPiiririkkujaEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Piiririkkuja o", Piiririkkuja.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
