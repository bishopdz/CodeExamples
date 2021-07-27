/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: DbRoleRepository
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Services
{
    public class DbRoleRepository : IRoleRepository
    {
        private ProjectManagerDbContext _db;

        public DbRoleRepository(ProjectManagerDbContext db)
        {
            _db = db;
        }

        //Creates a role in the Role table
        public Role Create(Role role)
        {
            _db.Role.Add(role);
            _db.SaveChanges();
            return role;
        }

        //Deletes a role in the Role table
        public void Delete(int id)
        {
            Role roleToDelete = Read(id);
            if (roleToDelete.Name.ToLower() != "member")
            {
                _db.Role.Remove(roleToDelete);
                _db.SaveChanges();
            }
        }

        //Reads a role from the Role table based on an id
        public Role Read(int id)
        {
            return _db.Role.FirstOrDefault(r => r.Id == id);
        }

        //Reads all roles from the Role table
        public ICollection<Role> ReadAll()
        {
            return _db.Role.ToList();
        }

        //Retrieves a role from the Role table, updates it, and commits it to the database
        public void Update(int id, Role role)
        {
            Role roleToUpdate = Read(id);
            roleToUpdate.Name = role.Name;
            roleToUpdate.Description = role.Description;
            _db.SaveChanges();
        }
    }
}
