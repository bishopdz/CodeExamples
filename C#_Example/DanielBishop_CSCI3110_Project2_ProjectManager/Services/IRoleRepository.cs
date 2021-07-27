/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: IRoleRepository
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Services
{
    public interface IRoleRepository
    {
        Role Create(Role role);
        Role Read(int id);
        ICollection<Role> ReadAll();
        void Update(int id, Role role);
        void Delete(int id);
    }
}
