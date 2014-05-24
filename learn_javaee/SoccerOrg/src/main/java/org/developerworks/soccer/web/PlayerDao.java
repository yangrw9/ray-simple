package org.developerworks.soccer.web;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.xml.bind.JAXBElement;

import org.developerworks.soccer.model.Player;
//import org.developerworks.soccer.model.Roster;
import org.developerworks.soccer.model.Team;

@Path("/players")
public class PlayerDao {
	private EntityManager mgr = DaoHelper.getInstance().getEntityManager();
	
	@POST
	@Consumes("application/json")
	@Produces("application/json")
	public Player addPlayer(JAXBElement<Player> player){
		Player p = player.getValue();
		EntityTransaction txn = mgr.getTransaction();
		txn.begin();
		Team t = p.getTeam();
		Team mt = mgr.merge(t);
		p.setTeam(mt);
		mgr.persist(p);
		txn.commit();
		return p;
	}
	
	@GET
	@Produces("application/json")
	public List<Player> getAllPlayers(){
		TypedQuery<Player> query = 
			mgr.createQuery("SELECT p FROM Player p", Player.class);
		return query.getResultList();
	}
}
