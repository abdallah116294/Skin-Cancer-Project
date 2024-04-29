using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.AuthModels
{
    public class ProcessResult
    {
        public bool IsSucceeded { get;set; }
        
        public string Message { get; set; } = string.Empty;
    }
}
