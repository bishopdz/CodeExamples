/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: ProjectRoleController
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.ViewModels;
using DanielBishop_CSCI3110_Project2_ProjectManager.Services;
using Microsoft.AspNetCore.Mvc;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Controllers
{
    public class ProjectRoleController : Controller
    {
        private IProjectRoleRepository _projectRoleRepo;
        private IPersonRepository _personRepo;
        private IProjectRepository _projectRepo;
        private IRoleRepository _roleRepo;

        public ProjectRoleController (IProjectRoleRepository projectRoleRepo, IPersonRepository personRepo, IProjectRepository projectRepo, IRoleRepository roleRepo)
        {
            _projectRoleRepo = projectRoleRepo;
            _personRepo = personRepo;
            _projectRepo = projectRepo;
            _roleRepo = roleRepo;
        }

        //Returns a page that enables people to be assigned to a project. 
        public IActionResult AssignToProject(int projectId)
        {
            //Gets all of the projectRoles that match the project id.
            var projectRoles = _projectRoleRepo.ReadAll().Where(pr => pr.ProjectId == projectId);

            //Creates a View Model to hold the project and a list of people assigned to it.
            var model = new AssignToProjectVM
            {
                Project = _projectRepo.Read(projectId),
                People = new List<Person>()
            };

            //Gets all people from the database.
            var allPeople = _personRepo.ReadAll();

            foreach (var person in allPeople)
            {
                //Determines if the person is already assigned to the project.
                int i = 0;

                //loops through each projectRole to see if a person is assigned to a project.
                foreach (var projectRole in projectRoles)
                {
                    //This will only happen if the person is already assigned to the project.
                    if (projectRole.PersonId == person.Id)
                    {
                        i++;
                    }
                }
                //If the person is not assigned to the project add them to the model.
                if (i == 0)
                {
                    model.People.Add(person);
                }
                
            }
            model.People = model.People.OrderBy(x => x.FirstName).ToList();
            return View(model);
        }

        //Assigns the person to a project and returns with /Project/Details/projectId
        [HttpPost]
        public IActionResult Assign(int projectId, int personId)
        {
            if (ModelState.IsValid)
            {
                _projectRoleRepo.AssignToProject(personId, projectId);

                return RedirectToAction("Details", "Project", new { id = projectId });
            }
            return View();

        }

        //Returns a page that will display available roles for a person on a project
        public IActionResult AssignRole(int projectId, int personId)
        {
            //Creates a View Model to hold the project, the person, and roles available to the person.
            var model = new AssignRoleVM
            {
                Project = _projectRepo.Read(projectId),
                Person = _personRepo.Read(personId),
                Roles = new List<Role>()
            };

            var allRoles = _roleRepo.ReadAll();
            var projectRoles = _projectRoleRepo.ReadAll();

            foreach (var role in allRoles)
            {
                //Determines if the person already has the role.
                int i = 0;

                foreach (var projectRole in projectRoles)
                {
                    //If the person assigned to the project already has the role trigger so it will not be added to the list.
                    if(projectRole.ProjectId == projectId && projectRole.PersonId == personId && projectRole.RoleId == role.Id )
                    {
                        i++;
                    }
                }
                //If the person does not have the role, add it to the model.
                if (i == 0)
                {
                    model.Roles.Add(role);
                }
            }
            model.Roles = model.Roles.OrderBy(x => x.Name).ToList();
            return View(model);
        }

        //Assigns the role to a person on a project and returns with /Project/Details/projectId
        [HttpPost]
        public IActionResult AssignToRole(int projectId, int personId, int roleId, decimal hourlyRate)
        {
            if (ModelState.IsValid)
            {
                _projectRoleRepo.AssignRole(personId, projectId, roleId, hourlyRate);

                return RedirectToAction("Details", "Project", new { id = projectId });
            }
            return View();
        }

        //Returns /Project/DeleteRole and displays the information for deleting a role from a person that is on a project.
        public IActionResult DeleteRole(int projectId, int personId)
        {
            var projectRoles = _projectRoleRepo.ReadAll();

            var model = new DeleteRoleVM
            {
                Project = _projectRepo.Read(projectId),
                Person = _personRepo.Read(personId),
                Roles = _roleRepo.ReadAll(),
                ProjectRoles = from projectRole in projectRoles
                               where projectRole.ProjectId == projectId && projectRole.PersonId == personId
                               orderby projectRole.Role.Name
                               select projectRole
            };

            return View(model);
        }

        //Deletes the role of a person assigned to a project from the database and returns /Project/Details/projectId
        [HttpPost]
        public IActionResult DeleteRoleConfirmed(int projectId, int personId, int roleId)
        {
            _projectRoleRepo.DeleteRole(projectId, personId, roleId);

            return RedirectToAction("Details", "Project", new { id = projectId });
        }

        //Returns /Project/DeletePersonFromProject and displays the information for deleting a person from a project.
        public IActionResult DeletePersonFromProject(int projectId, int personId)
        {
            var projectRoles = _projectRoleRepo.ReadAll();
            var model = new DeletePersonFromProjectVM
            {
                Project = _projectRepo.Read(projectId),
                Person = _personRepo.Read(personId),
                Roles = _roleRepo.ReadAll(),
                ProjectRoles = from projectRole in projectRoles
                               where projectRole.ProjectId == projectId && projectRole.PersonId == personId
                               orderby projectRole.Role.Name
                               select projectRole
            };
           
            return View(model);
        }

        //Deletes the Person and their roles from the Project and returns the Project/Details/projectId
        [HttpPost]
        public IActionResult DeletePersonFromProjectConfirmed(int projectId, int personId)
        {
            _projectRoleRepo.DeletePersonFromProject(projectId, personId);

            return RedirectToAction("Details", "Project", new { id = projectId });
        }
        
    }
}