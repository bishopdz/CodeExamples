/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: IProjectRoleRepository
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Services
{
    public interface IProjectRoleRepository
    {
        ProjectRole Read(int id);

        ICollection<ProjectRole> ReadAll();


        void AssignToProject(int personId, int projectId);

        void AssignRole(int personId, int projectId, int roleId, decimal hourlyRate);

        void DeleteRole(int projectId, int personId, int roleId);

        void DeletePersonFromProject(int projectId, int personId);
    }
}
