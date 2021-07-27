/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: ProjectManagerDbContext
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models.Services
{
    public class ProjectManagerDbContext : DbContext
    {
        public ProjectManagerDbContext(DbContextOptions options) : base(options)
        {

        }

        public virtual DbSet<Person> Person { get; set; }
        public virtual DbSet<Project> Project { get; set; }
        public virtual DbSet<ProjectRole> ProjectRole { get; set; }
        public virtual DbSet<Role> Role { get; set; }

    }
}
