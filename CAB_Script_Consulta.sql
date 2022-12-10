---Consulta
select md."name", bd."name", gr."name", cl."name", car.number_plate, car.kms_total, car.date_acquisition, ir.number_policy, cp."name"
from  practica_CAB.cars car, practica_CAB.models md, practica_CAB.brands bd, practica_CAB.parent_groups gr, 
practica_CAB.colours cl, practica_CAB.insurances ir, practica_CAB.companies cp
where car.id_model = md.id_model and md.id_brand = bd.id_brand and bd.id_group = gr.id_group
and car.id_colour = cl.id_colour and car.id_car = ir.id_car and ir.id_company = cp.id_company
