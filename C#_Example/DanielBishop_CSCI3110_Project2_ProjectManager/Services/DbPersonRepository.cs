/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: DbPersonRepository
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Services;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Services
{
    public class DbPersonRepository : IPersonRepository
    {
        private ProjectManagerDbContext _db;

        public DbPersonRepository(ProjectManagerDbContext db)
        {
            _db = db;
        }

        //Creates a person in the Person table
        public Person Create(Person person)
        {
            _db.Person.Add(person);
            _db.SaveChanges();
            return person;
        }

        //Deletes a person in the Person table
        public void Delete(int id)
        {
            Person personToDelete = Read(id);
            _db.Person.Remove(personToDelete);
            _db.SaveChanges();
        }

        //Reads a person from the Person table based on an id
        public Person Read(int id)
        {
            return _db.Person.FirstOrDefault(p => p.Id == id);
        }

        //Reads all people from the Person table
        public ICollection<Person> ReadAll()
        {
            return _db.Person.ToList();
        }

        //Retrieves a person from the Person table, updates it, and commits it to the database
        public void Update(int id, Person person)
        {
            Person personToUpdate = Read(id);
            personToUpdate.FirstName = person.FirstName;
            personToUpdate.MiddleName = person.MiddleName;
            personToUpdate.LastName = person.LastName;
            personToUpdate.Email = person.Email;
            _db.SaveChanges();
        }

    }
}
