/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: DeletePersonFromProjectVM
 * Sumary: Serves as a model for deleting a person from a project
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models.ViewModels
{
    public class DeletePersonFromProjectVM
    {
        public Project Project { get; set; }

        public Person Person { get; set; }

        public ICollection<Role> Roles { get; set; }

        public IEnumerable<ProjectRole> ProjectRoles { get; set; }
    }
}
