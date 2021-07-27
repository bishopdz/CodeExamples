/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: ProjectReportVM
 * Sumary: Serves as a model for the Project Report
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models.ViewModels
{
    public class ProjectReportVM
    {
        public List<Project> Projects { get; set; }

        public List<Person> People { get; set; }

        public List<ProjectRole> ProjectRoles { get; set; }
    }
}
