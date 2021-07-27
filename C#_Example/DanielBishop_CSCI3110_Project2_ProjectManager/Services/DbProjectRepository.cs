/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: DbProjectRepository
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Services
{
    public class DbProjectRepository : IProjectRepository
    {
        private ProjectManagerDbContext _db;

        public DbProjectRepository(ProjectManagerDbContext db)
        {
            _db = db;
        }

        //Creates a project in the Project table
        public Project Create(Project project)
        {
            _db.Project.Add(project);
            _db.SaveChanges();
            return project;
        }

        //Deletes a project in the Project table
        public void Delete(int id)
        {
            Project projectToDelete = Read(id);
            _db.Project.Remove(projectToDelete);
            _db.SaveChanges();
        }

        //Reads a project from the Project table based on an id
        public Project Read(int id)
        {
            return _db.Project.FirstOrDefault(p => p.Id == id);
        }

        //Reads all projects from the Project table
        public ICollection<Project> ReadAll()
        {
            return _db.Project.ToList();
        }

        //Retrieves a project from the Project table, updates it, and commits it to the database
        public void Update(int id, Project project)
        {
            Project projectToUpdate = Read(id);
            projectToUpdate.Name = project.Name;
            projectToUpdate.StartDate = project.StartDate;
            projectToUpdate.DueDate = project.DueDate;
            _db.SaveChanges();
        }
    }
}
