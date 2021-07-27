/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: DeleteRoleVM
 * Sumary: Serves as a model for deleting a role from a person that's assigned to a project
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models.ViewModels
{
    public class DeleteRoleVM
    {
        public Project Project { get; set; }

        public Person Person { get; set; }


        public ICollection<Role> Roles { get; set; }

        public IEnumerable<ProjectRole> ProjectRoles { get; set; }
    }
}
