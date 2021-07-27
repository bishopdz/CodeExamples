/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: DetailsVM
 * Sumary: Serves as a model for the /Project/Details/personId page
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models.ViewModels
{
    public class DetailsVM
    {
        public Project Project { get; set; }

        public List<Person> People { get; set; }

        public List<ProjectRole> ProjectRoles { get; set; }

        public List<KeyValuePair<Person, List<Role>>> PeopleRoles { get; set; }

        public string DaysUntilDue { get; set; }

        public int NumberOfPeople { get; set; }

        public List<int> NumberOfRoles { get; set; }


    }
}
