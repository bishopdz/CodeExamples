using System;

namespace DanielBishop_CSCI3110_Project2_ProjectManager.Models
{
    public class ErrorViewModel
    {
        public string RequestId { get; set; }

        public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);
    }
}