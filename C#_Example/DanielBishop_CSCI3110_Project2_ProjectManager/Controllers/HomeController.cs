/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: HomeController
 */
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using DanielBishop_CSCI3110_Project2_ProjectManager.Models;
using DanielBishop_CSCI3110_Project2_ProjectManager.Services;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Controllers
{
    public class HomeController : Controller
    {
        private IProjectRepository _projectRepo;
        private IProjectRoleRepository _projectRoleRepo;
        private IPersonRepository _personRepo;
        private IRoleRepository _roleRepo;


        public HomeController(IProjectRepository projectRepo, IProjectRoleRepository projectRoleRepo, IPersonRepository personRepo, IRoleRepository roleRepo)
        {
            _projectRepo = projectRepo;
            _projectRoleRepo = projectRoleRepo;
            _personRepo = personRepo;
            _roleRepo = roleRepo;
        }

        //Returns the default Index page /home/index
        public IActionResult Index()
        {
            ViewData["numberOfPeople"] = _personRepo.ReadAll().Count();
            ViewData["numberOfProjects"] = _projectRepo.ReadAll().Count();
            ViewData["numberOfRoles"] = _roleRepo.ReadAll().Count();
            return View();
        }

    }
}
