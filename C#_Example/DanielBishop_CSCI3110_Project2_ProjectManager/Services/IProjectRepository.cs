/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: IProjectRepository
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Services
{
    public interface IProjectRepository
    {
        Project Create(Project project);
        Project Read(int id);
        ICollection<Project> ReadAll();
        void Update(int id, Project project);
        void Delete(int id);
    }
}
