/*
 * Created by: Daniel Bishop
 * Project 2: ProMan
 * File Name: IPersonRepository
 */
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Services
{
    public interface IPersonRepository
    {
        Person Create(Person person);
        Person Read(int id);
        ICollection<Person> ReadAll();
        void Update(int id, Person person);
        void Delete(int id);

    }
}
