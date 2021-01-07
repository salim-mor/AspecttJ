
package aspecttt;

import beans.Client;
import org.aspectj.lang.ProceedingJoinPoint;

import java.io.IOException;
import java.util.*;
import java.util.logging.FileHandler;
import java.util.logging.Logger;

public aspect ProjectAspect {

    private static Logger logger = Logger.getLogger(ProjectAspect.class.getName());

    pointcut retirerAsp() : execution(public void beans.Client.retirer(*));
    pointcut verserAsp() : execution(public void beans.Client.verser(*));


    public ProjectAspect() throws IOException {
        logger.addHandler(new FileHandler("log.xml"));
        logger.setUseParentHandlers(false);
    }

    Object around() : retirerAsp() {
        Client client = (Client) thisJoinPoint.getTarget();

        long debut = System.currentTimeMillis();

        Object rep =  proceed();
        long fin = System.currentTimeMillis();
        logger.info("-------------------------------------------------");
        logger.info("Operation retirer // name : "+client.getNom()+" nouveau solde : "+ client.getCp().getSolde()+" Time of execution : "+ (fin-debut));

        return rep;
    }

    Object around() : verserAsp(){
        Client client = (Client) thisJoinPoint.getTarget();
        Object rep;
        if ( (Double)thisJoinPoint.getArgs()[0]<= client.getCp().getSolde()){
            long debut = System.currentTimeMillis();
            rep =  proceed();
            long fin = System.currentTimeMillis();
            logger.info("Operation verser // name : "+client.getNom()+
                    "nouveau solde : "+ client.getCp().getSolde()+" Time of execution : "+ (fin-debut));
            logger.info("-------------------------------------------------");
        }else {
            logger.info("Error");
            logger.info("-------------------------------------------------");
            rep=null;
        }




        return rep;
    }
}
