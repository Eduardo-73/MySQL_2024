insert into Entidades (codEntidad, nomEntidad, dirEnvio, dirPostal) values
(1, 'Empresa A', 'Calle Principal 123', '12345'),
(2, 'Empresa B', 'Avenida Central 456', '67890'),
(3, 'Empresa C', 'Plaza Mayor 789', '54321'),
(4, 'Empresa D', 'Calle Secundaria 321', '09876'),
(5, 'Empresa E', 'Paseo del Sol 987', '13579');
insert into Clientes (codCliente, codEnt, nombre, ape1cli, ape2cli, dni, cuentaBancaria, fechaNac, fecAltaPlan, correo) values
(1, 1, 'Juan', 'González', 'Pérez', '12345678A', 'ES12345678901234567890', '1990-05-15', '2022-01-01', 'juan@example.com'),
(2, 2, 'María', 'López', 'Martínez', '87654321B', 'ES21098765432109876543', '1985-08-20', '2021-12-15', 'maria@example.com'),
(3, 3, 'José', 'Sánchez', 'Fernández', '13579246C', 'ES98765432109876543210', '1978-03-10', '2022-02-28', 'jose@example.com'),
(4, 4, 'Ana', 'Martín', 'García', '98765432D', 'ES45678901234567890123', '1995-11-28', '2022-03-10', 'ana@example.com'),
(5, 5, 'Carlos', 'Ruiz', 'López', '56789012E', 'ES67890123456789012345', '1980-07-03', '2021-11-05', 'carlos@example.com');
insert into PlanProductos (codPlan, nombrePlan, importe) values
(1, 'Plan Básico', 25.00),
(2, 'Plan Estándar', 45.00),
(3, 'Plan Premium', 65.00),
(4, 'Plan Empresarial', 100.00),
(5, 'Plan Personalizado', 80.00);
insert into Recibos (codRecibo, codCli, pagado, fecRecibo, importeFinal) values
(1, 1, true, '2024-01-01', 25.00),
(2, 2, true, '2024-02-01', 45.00),
(3, 3, true, '2024-03-01', 65.00),
(4, 4, true, '2024-04-01', 100.00),
(5, 5, true, '2024-05-01', 80.00);
insert into DetallePlan (codCli, codPProd, estadoPlan, fecBajaPlan, fecAltaPlan) values
(1, 1, 'Pagado', NULL, '2024-01-01'),
(2, 2, 'Pagado', NULL, '2024-02-01'),
(3, 3, 'Pagado', NULL, '2024-03-01'),
(4, 4, 'Pagado', NULL, '2024-04-01'),
(5, 5, 'Pagado', NULL, '2024-05-01');