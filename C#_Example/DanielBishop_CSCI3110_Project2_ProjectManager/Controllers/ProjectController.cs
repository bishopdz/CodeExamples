/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: ProjectController
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
    public class ProjectController : Controller
    {
        private IProjectRepository _projectRepo;
        private IProjectRoleRepository _projectRoleRepo;
        private IPersonRepository _personRepo;
        private IRoleRepository _roleRepo;

        public ProjectController(IProjectRepository projectRepo, IProjectRoleRepository projectRoleRepo, IPersonRepository personRepo, IRoleRepository roleRepo)
        {
            _projectRepo = projectRepo;
            _projectRoleRepo = projectRoleRepo;
            _personRepo = personRepo;
            _roleRepo = roleRepo;
        }

        //Returns /Project/Index to display all projects
        public IActionResult Index()
        {
            var model = _projectRepo.ReadAll();
            return View(model);
        }

        //Returns a form to create a project. /Project/Create
        public IActionResult Create()
        {
            return View();
        }

        //Calls the create for a project. Returns /Project/Index 
        [HttpPost]
        public IActionResult Create(Project project)
        {
            if (ModelState.IsValid)
            {
                _projectRepo.Create(project);

                return RedirectToAction("Index");

            }
            return View(project);

        }

        //Returns /Project/Edit/id
        public IActionResult Edit(int id)
        {
            var project = _projectRepo.Read(id);

            if (project == null)
            {

                return RedirectToAction("Index");

            }
            return View(project);
        }

        //Calls the Update method to retrieve and update the specified project in /Project/Edit/id
        [HttpPost]
        public IActionResult Edit(Project project)
        {
            if (ModelState.IsValid)
            {
                _projectRepo.Update(project.Id, project);

                return RedirectToAction("Index");

            }
            return View(project);
        }

        //Returns /Project/Details/id
        public IActionResult Details(int id)
        {
            var project = _projectRepo.Read(id);
            if (project == null)
            {

                return RedirectToAction("Index");

            }



            //Gets all of the projectRoles that match the project id.
            var projectRoleList = _projectRoleRepo.ReadAll().Where(p => p.ProjectId == id);

            //A list that will hold the people assigned to the project
            List<Person> assignedPeopleList = new List<Person>();

            //Gets all of the roles from the database
            var allRoles = _roleRepo.ReadAll();
            //A list that will hold the roles people assigned to the project have
            List<Role> roleList = new List<Role>();

            var model = new DetailsVM
            {
                Project = project,
                DaysUntilDue = project.DueDate.Date.Subtract(DateTime.Now.Date).ToString(),
                ProjectRoles = projectRoleList.ToList(),
                PeopleRoles = new List<KeyValuePair<Person, List<Role>>>(),
                NumberOfRoles = new List<int>()
            };

            //loops for every element in projectRoleList
            foreach (var projectRole in projectRoleList)
            {
                if (assignedPeopleList == null)
                {
                    var person = _personRepo.Read(projectRole.PersonId);
                    assignedPeopleList.Add(person);

                }
                else
                {

                    int i = 0;
                    int index = 0;
                    List<Role> personsProjectRoles = new List<Role>();

                    foreach (var person in assignedPeopleList)
                    {

                        foreach (var pR in projectRoleList)
                        {

                            //if (pR.ProjectId == project.Id && pR.PersonId == person.Id)
                            //{
                            var role = _roleRepo.Read(pR.RoleId);
                            personsProjectRoles.Add(role);
                            //}
                        }
                        if (projectRole.PersonId == person.Id)
                        {
                            i++;
                        }
                    }
                    if (i == 0)
                    {

                        var person = _personRepo.Read(projectRole.PersonId);
                        model.PeopleRoles.Insert(index, new KeyValuePair<Person, List<Role>>(person, personsProjectRoles));
                        index++;

                    }
                }
            }



            model.PeopleRoles = model.PeopleRoles.OrderBy(p => p.Key.FirstName).ToList();
            model.NumberOfPeople = model.PeopleRoles.Count();
            return View(model);
        }

        //Returns /Project/Delete/id to confirm deletion
        public IActionResult Delete(int id)
        {
            var project = _projectRepo.Read(id);

            if (project == null)
            {
                return RedirectToAction("Index");

            }
            return View(project);
        }

        //Calls the delete method based on the id passed from /Project/Delete
        [HttpPost, ActionName("Delete")]
        public IActionResult DeleteConfirmed(int id)
        {
            _projectRepo.Delete(id);

            return RedirectToAction("Index");
        }
    }
}