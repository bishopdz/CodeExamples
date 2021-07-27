/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: AssignToProjectVM
 * Sumary: Creates a model for assigning a person to a project
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models.ViewModels
{
    public class AssignToProjectVM
    {
        public Project Project { get; set; }

        public List<Person> People { get; set; }
    }
}
