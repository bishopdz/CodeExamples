/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: DbProjectRoleRepository
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Services;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Services
{
    public class DbProjectRoleRepository : IProjectRoleRepository
    {
        private ProjectManagerDbContext _db;

        public DbProjectRoleRepository(ProjectManagerDbContext db)
        {
            _db = db;
        }

        //Reads a ProjectRole based on an id and eager loads Person, Role, and Project.
        public ProjectRole Read(int id)
        {
            return _db.ProjectRole.Include(p => p.Person).Include(r => r.Role).Include(pro => pro.Project).FirstOrDefault(pr => pr.Id == id);
        }

        //Reads all of the ProjectRoles from the ProjectRole table.
        public ICollection<ProjectRole> ReadAll()
        {
            return _db.ProjectRole.ToList();
        }

        //Assigns a person to a project and defaults the role to Member.
        public void AssignToProject(int personId, int projectId)
        {
            var person = _db.Person.FirstOrDefault(p => p.Id == personId);
            var project = _db.Project.FirstOrDefault(pro => pro.Id == projectId);
            var role = _db.Role.FirstOrDefault(r => r.Name == "Member");
            var personProjectRecord = new ProjectRole
            {
                Person = person,
                Project = project,
                Role = role
            };
            person.ProjectRoles.Add(personProjectRecord);
            _db.SaveChanges();
        }

        //Assigns a role to a person assigned to a project.
        public void AssignRole(int personId, int projectId, int roleId, decimal hourlyRate)
        {
            var person = _db.Person.FirstOrDefault(p => p.Id == personId);
            var project = _db.Project.FirstOrDefault(pro => pro.Id == projectId);
            var role = _db.Role.FirstOrDefault(r => r.Id == roleId);
            var personProjectRecord = new ProjectRole
            {
                PersonId = personId,
                ProjectId = projectId,
                RoleId = roleId,
                HourlyRate = hourlyRate

            };
            person.ProjectRoles.Add(personProjectRecord);
            _db.SaveChanges();
        }


        //Deletes a role from a person assigned to a project.
        public void DeleteRole(int projectId, int personId, int roleId)
        {
            var projectRoles = ReadAll();
            foreach (var projectRole in projectRoles)
            {
                if (projectRole.ProjectId == projectId && projectRole.PersonId == personId && projectRole.RoleId == roleId)
                {
                    _db.ProjectRole.Remove(projectRole);
                    _db.SaveChanges();
                }
            }
        }

        //Deletes a Person and all of their roles from a Project.
        public void DeletePersonFromProject(int projectId, int personId)
        {
            var projectRoles = ReadAll();
            foreach (var projectRole in projectRoles)
            {
                if (projectRole.ProjectId == projectId && projectRole.PersonId == personId)
                {
                    _db.ProjectRole.Remove(projectRole);
                    _db.SaveChanges();
                }
            }
        }
    }
}
