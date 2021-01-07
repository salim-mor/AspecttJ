import beans.Client;
import beans.Compte;

public class Test {

    public static void main(String[] args) {
        Client client = new Client();
        Compte compte = new Compte();
        client.setNom("fa");
        client.setCp(compte);
        compte.setSolde(100);

        client.retirer(4);
        client.verser(100);
    }
}
