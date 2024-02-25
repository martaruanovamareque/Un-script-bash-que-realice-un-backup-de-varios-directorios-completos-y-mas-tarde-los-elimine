#!/bin/bash
# ● Función borrar backups creados anteriormente
function borrar_Backup(){
    # ● Borra os backups que creara fai 2 minutos ou menos 
    find /home/marta/Descargas/backup/backup_ruta* -mmin -2 -exec rm {} \;
    # ● Borra a carpeta log que creara fai 2 minutos ou menos 
    find /home/marta/Descargas/backup/log -mmin -2 -exec rm -r {} \;
    # ● Borra a carpeta Descargas que creara fai 2 minutos ou menos 
    find /home/marta/Descargas/backup/Descargas -mmin -2 -exec rm -r {} \;
}
# ● Comando para chamar á función
borrar_Backup