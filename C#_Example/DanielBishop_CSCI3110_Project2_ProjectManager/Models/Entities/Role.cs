/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: Role
 * Summary: Serves as a model for a Role
 */
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities
{
    public class Role
    {
        public int Id { get; set; }

        [Required, MaxLength(30)]
        public string Name { get; set; }

        [MaxLength(450)]
        public string Description { get; set; }

    }
}
