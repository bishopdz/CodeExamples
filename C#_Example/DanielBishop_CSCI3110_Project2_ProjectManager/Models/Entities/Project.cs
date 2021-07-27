/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: Project
 * Summary: Serves as a model for a Project
 */
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities
{
    public class Project
    {
        public int Id { get; set; }

        [Required, MaxLength(30)]
        public string Name { get; set; }

        [Required]
        public DateTime StartDate { get; set; }

        [Required]
        public DateTime DueDate { get; set; }

        public ICollection<ProjectRole> ProjectRoles { get; set; }

        public Project()
        {
            ProjectRoles = new List<ProjectRole>();
        }
    }
}
