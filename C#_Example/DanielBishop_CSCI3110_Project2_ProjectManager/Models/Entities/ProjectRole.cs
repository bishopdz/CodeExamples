/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: ProjectRole
 * Summary: Serves as a model for a ProjectRole
 */
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities
{
    public class ProjectRole
    {
        public int Id { get; set; }

        public int PersonId { get; set; }

        public int ProjectId { get; set; }

        public int RoleId { get; set; }

        [Required, Range(8.00, 100.00)]
        public decimal HourlyRate { get; set; }

        public Person Person { get; set; }

        public Project Project { get; set; }

        public Role Role { get; set; }

        public ProjectRole()
        {
            HourlyRate = 8;
        }

    }
}
