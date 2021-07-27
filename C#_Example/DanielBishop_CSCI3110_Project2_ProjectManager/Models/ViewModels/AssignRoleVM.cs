/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: AssignRoleVM
 * Sumary: Creates a model for assigning a role to a person thats on a project
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models.ViewModels
{
    public class AssignRoleVM
    {
        public Project Project { get; set; }

        public Person Person { get; set; }

        public List<Role> Roles { get; set; }

        [Required, Range(8.00, 100.00)]
        public decimal HourlyRate { get; set; }

        public AssignRoleVM()
        {
            HourlyRate = 8;
        }
    }
}
