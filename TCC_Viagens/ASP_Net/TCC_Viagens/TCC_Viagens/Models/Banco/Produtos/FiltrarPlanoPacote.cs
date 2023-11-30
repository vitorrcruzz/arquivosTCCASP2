using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace TCC_Viagens.Models.Banco.Produtos
{
    public class FiltrarPlanoPacote
    {
        [DisplayName("Código do Pacote")]
        public string IdPacote { get; set; }

        [StringLength(250, ErrorMessage = "Maximo de 250 Caracteres")]
        [Required(ErrorMessage = "Obrigátório informar o nome do Pacote")]
        [DisplayName("Pacote")]
        public string nmPacote { get; set; }

        [StringLength(250, ErrorMessage = "Maximo de 250 Caracteres")]
        [Required(ErrorMessage = "Obrigátório informar um Preço")]
        [DisplayName("Preço")]
        public string valor1 { get; set; }

        [StringLength(250, ErrorMessage = "Maximo de 250 Caracteres")]
        [Required(ErrorMessage = "Obrigátório informar um Preço")]
        [DisplayName("Preço")]
        public string valor2 { get; set; }

        [StringLength(250, ErrorMessage = "Maximo de 250 Caracteres")]
        [Required(ErrorMessage = "Obrigátório informar um Preço")]
        [DisplayName("Preço")]
        public string dsPreco { get; set; }

        [StringLength(250, ErrorMessage = "Maximo de 250 Caracteres")]
        [Required(ErrorMessage = "Obrigátório informar a Descrição do Pacote")]
        [DisplayName("Descrição")]
        public string dsPacote { get; set; }

        [DisplayName("Imagem")]
        public string Imagem { get; set; }

        [StringLength(80, ErrorMessage = "Maximo de 80 Caracteres")]
        [Required(ErrorMessage = "Obrigátório informar um Nome ")]
        [DisplayName("País")]
        public string nmPais { get; set; }
    }
}