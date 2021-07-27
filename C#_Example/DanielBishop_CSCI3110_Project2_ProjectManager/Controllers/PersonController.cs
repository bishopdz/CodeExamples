/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: PersonController
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
    public class PersonController : Controller
    {
        private IPersonRepository _personRepo;

        public PersonController(IPersonRepository personRepo)
        {
            _personRepo = personRepo;
        }

        //Returns /Person/Index
        public IActionResult Index()
        {
            var model = _personRepo.ReadAll();
            return View(model);
        }

        //Returns /Person/Create
        public IActionResult Create()
        {
            return View();
        }


        //Creates the person in the database from /Person/Create
        [HttpPost]
        public IActionResult Create(Person person)
        {
            if (ModelState.IsValid)
            {
                _personRepo.Create(person);

                return RedirectToAction("Index");

            }
            return View(person);

        }

        //Returns /Person/Edit/id
        public IActionResult Edit(int id)
        {
            var person = _personRepo.Read(id);

            if (person == null)
            {

                return RedirectToAction("Index");

            }
            return View(person);
        }

        //Calls the Update method to retrieve and update the specified person in /Person/Edit/id
        [HttpPost]
        public IActionResult Edit(Person person)
        {
            if (ModelState.IsValid)
            {
                _personRepo.Update(person.Id, person);

                return RedirectToAction("Index");

            }
            return View(person);
        }

        //Returns /Person/Details/id
        public IActionResult Details(int id)
        {
            var person = _personRepo.Read(id);
            if (person == null)
            {

                return RedirectToAction("Index");

            }
            return View(person);
        }

        //Returns /Person/Delete/id to confirm deletion
        public IActionResult Delete(int id)
        {
            var person = _personRepo.Read(id);

            if (person == null)
            {
                return RedirectToAction("Index");

            }
            return View(person);
        }

        //Calls the delete method based on the id passed from /Person/Delete
        [HttpPost, ActionName("Delete")]
        public IActionResult DeleteConfirmed(int id)
        {
            _personRepo.Delete(id);

            return RedirectToAction("Index");
        }
    }
}