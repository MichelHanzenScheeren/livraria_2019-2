﻿using Model.Validations;
using System;
using System.ComponentModel.DataAnnotations;

namespace Model.Attributes
{
    public class Venda
    {
        [Key]
        public int ID { get; set; }

        [Required(ErrorMessage = "Preenchimento obrigatório!")]
        [DataType(DataType.DateTime, ErrorMessage = "Data inválida!")]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy HH:mm}")]
        public DateTime Data { get; set; }

        [ValidarNumero(1)]
        [Required(ErrorMessage = "Preenchimento obrigatório!")]
        public int Quantidade { get; set; }

        [Display(Name = "Valor Unitário (R$)")]
        [Required(ErrorMessage = "Preenchimento obrigatório!")]
        [DisplayFormat(DataFormatString = "{0:F2}")]
        [ValidarNumero(0)]
        public decimal ValorUnitario { get; set; }

        [Required(ErrorMessage = "Preenchimento obrigatório!")]
        public int ClienteID { get; set; }
        public virtual Cliente Cliente { get; set; }

        [Required(ErrorMessage = "Preenchimento obrigatório!")]
        public int LivroID { get; set; }
        public virtual Livro Livro { get; set; }
    }
}
