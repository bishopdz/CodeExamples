/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: ReportsController
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.ViewModels;
using DanielBishop_CSCI3110_Project2_ProjectManager.Services;
using Microsoft.AspNetCore.Mvc;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Controllers
{
    public class ReportsController : Controller
    {
        private IProjectRoleRepository _projectRoleRepo;
        private IPersonRepository _personRepo;
        private IProjectRepository _projectRepo;
        private IRoleRepository _roleRepo;

        public ReportsController(IProjectRoleRepository projectRoleRepo, IPersonRepository personRepo, IProjectRepository projectRepo, IRoleRepository roleRepo)
        {
            _projectRoleRepo = projectRoleRepo;
            _personRepo = personRepo;
            _projectRepo = projectRepo;
            _roleRepo = roleRepo;
        }
        
        //Returns a view with the Project Report
        public IActionResult ProjectReport()
        {
            var model = new ProjectReportVM
            {
                Projects = _projectRepo.ReadAll().ToList(),
                //People = 
            };
            return View();
        }

        //Returns a view with the Person Report
        public IActionResult PeopleReport()
        {
            return View();
        }
    }
}