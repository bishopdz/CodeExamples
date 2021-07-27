/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: RoleController
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using DanielBishop_CSCI3110_Project2_ProjectManager.Services;
using Microsoft.AspNetCore.Mvc;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Controllers
{
    public class RoleController : Controller
    {
        private IRoleRepository _roleRepo;

        public RoleController(IRoleRepository roleRepo)
        {
            _roleRepo = roleRepo;
        }

        //Returns /Role/Index
        public IActionResult Index()
        {
            var model = _roleRepo.ReadAll();
            return View(model);
        }

        //Returns /Role/Create
        public IActionResult Create()
        {
            return View();
        }

        //Creates the role in the database from /Role/Create
        [HttpPost]
        public IActionResult Create(Role role)
        {
            if (ModelState.IsValid)
            {
                _roleRepo.Create(role);

                return RedirectToAction("Index");

            }
            return View(role);

        }

        //Returns /Role/Edit/id
        public IActionResult Edit(int id)
        {
            var role = _roleRepo.Read(id);

            if (role == null)
            {

                return RedirectToAction("Index");

            }
            return View(role);
        }

        //Calls the Update method to retrieve and update the specified role in /Role/Edit/id
        [HttpPost]
        public IActionResult Edit(Role role)
        {
            if (ModelState.IsValid)
            {
                _roleRepo.Update(role.Id, role);

                return RedirectToAction("Index");

            }
            return View(role);
        }

        //Returns /Role/Details/id
        public IActionResult Details(int id)
        {
            var role = _roleRepo.Read(id);
            if (role == null)
            {

                return RedirectToAction("Index");

            }
            return View(role);
        }

        //Returns /Role/Delete/id to confirm deletion
        public IActionResult Delete(int id)
        {
            var role = _roleRepo.Read(id);

            if (role == null)
            {
                return RedirectToAction("Index");

            }
            return View(role);
        }

        //Calls the delete method based on the id passed from /Role/Delete
        [HttpPost, ActionName("Delete")]
        public IActionResult DeleteConfirmed(int id)
        {
            _roleRepo.Delete(id);

            return RedirectToAction("Index");
        }
    }
}