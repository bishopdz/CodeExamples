/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: Person
 * Summary: Serves as a model for a Person
 */
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities
{
    public class Person
    {
        public int Id { get; set; }

        [Required, MaxLength(30)]
        public string FirstName { get; set; }

        [MaxLength(30)]
        public string MiddleName { get; set; }

        [Required, MaxLength(30)]
        public string LastName { get; set; }

        [Required]
        public string Email { get; set; }

        public ICollection<ProjectRole> ProjectRoles { get; set; }

        public Person()
        {
            ProjectRoles = new List<ProjectRole>();
        }
    }
}
