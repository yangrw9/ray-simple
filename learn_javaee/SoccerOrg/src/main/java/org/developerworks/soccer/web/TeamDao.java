package org.developerworks.soccer.web;

import java.util.Collection;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.developerworks.soccer.model.Team;

@Path("/teams")
public class TeamDao {
	
	private EntityManager mgr = DaoHelper.getInstance().getEntityManager();
	
	@GET
	@Produces("application/json")	
	public Collection<Team> getAll(){
		TypedQuery<Team> query = mgr.createQuery("SELECT t FROM Team t", Team.class);
		return query.getResultList();
	}
	
	@POST
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json")
	public Team createTeam(@FormParam("teamName") String teamName){
		Team team = new Team();
		team.setName(teamName);
		EntityTransaction txn = mgr.getTransaction();
		txn.begin();
		mgr.persist(team);
		txn.commit();
		return team;
	}
}
