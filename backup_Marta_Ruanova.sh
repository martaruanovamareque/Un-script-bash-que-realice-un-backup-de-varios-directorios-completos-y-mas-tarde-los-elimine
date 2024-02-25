#!/bin/bash
# ● Crear función para ver que directorios teñen un tamaño
# superior a 20kB para realizar a 
# comprensión e se non é maior empregar un cp para copiar
function extraer_Tamanho(){
    
    # ● Variable para coller o tamaño do directorio /var/log
    tamanho_var_log=$( du -sh /var/log )
    
    # ● Variable para coller o tamaño do directorio /home/marta/Descargas
    tamanho_descargas=$( du -sh /home/marta/Descargas )
    
    # ● Variables para coller da liña do tamaño o tamaño en si e non a ruta
    tamanho_ruta1=$( echo $tamanho_var_log | tr -s " " | cut -d " " -f1 )
    tamanho_ruta2=$( echo $tamanho_descargas | tr -s " " | cut -d " " -f1 )
    
    # ● Variables para saber o formato do tamaño
    tamanhoGB="*G"
    tamanhoMG="*M"
    tamanhoKG="*K"

    # ● If para comparar se o tamaño do directorio /var/log está en GB
    if [[ $tamanho_ruta1 == $tamanhoGB ]] ;
    then
        # ● Variable para quitar a letra G do tamaño
        tamanho_ruta1_GB=$( echo $tamanho_ruta1 | cut -d "G" -f1 )
        # ● Variable para convertir os GB do tamaño en KB
        tamanho_ruta1_KB=$(( $tamanho_ruta1_GB *1024 *1024 ))
    # ● Elif para comparar se o tamaño do directorio /var/log está en MG
    elif [[ $tamanho_ruta1 == $tamanhoMG ]] ;
    then
        # ● Variable para quitar a letra M do tamaño
        tamanho_ruta1_MG=$( echo $tamanho_ruta1 | cut -d "M" -f1 )
        # ● Variable para convertir os MB en KB
        tamanho_ruta1_KB=$(($tamanho_ruta1_MG *1024 ))
    # ● Elif para comparar se o tamaño do directorio /var/log está en KB
    elif [[ $tamanho_ruta1 == $tamanhoKG ]] ;
    then
        # ● Variable para quitar a letra K do tamaño
        tamanho_ruta1_KB=$( echo $tamanho_ruta1 | cut -d "K" -f1)
    fi

    # ● If para comparar se o tamaño do directorio Descargas está en GB
    if [[ $tamanho_ruta2 == $tamanhoGB ]] ;
    then
        # ● Variable para quitar a letra G do tamaño
        tamanho_ruta2_GB=$( echo $tamanho_ruta2 | cut -d "G" -f1 )
        # ● Variable para convertir os GB do tamaño en KB
        tamanho_ruta2_KB=$(( $tamanho_ruta2_GB *1024 *1024 ))
    # ● Elif para comparar se o tamaño do directorio Descargas está en MG
    elif [[ $tamanho_ruta2 == $tamanhoMG ]] ;
    then
        # ● Variable para quitar a letra M do tamaño
        tamanho_ruta2_MG=$( echo $tamanho_ruta2 | cut -d "M" -f1 )
        tamanho_ruta2_KB=$(( $tamanho_ruta2_MG *1024 ))
    # ● Elif para comparar se o tamaño do directorio Descargas está en KB
    elif [[ $tamanho_ruta2 == $tamanhoKG ]] ;
    then
        # ● Variable para quitar a letra K do tamaño
        tamanho_ruta2_KB=$( echo $tamanho_ruta2 | cut -d "K" -f1 )
    fi
    
    # ● Variable que establece o máximo de KB
    tamanho_maximo=20

    # ● Variables que gardan as rutas tanto das que se fan backup como onde se gardan estes
    ruta_var="/var/log"
    ruta_descargas="/home/marta/Descargas"
    ruta_destino="/home/marta/Descargas/backup"
    
    # ● Variables para establecer o nome dos backup para cada ruta en formato hora_minuto_segundo_día_mes_ano
    ruta1="backup_ruta1_`date +%H`_`date +%M`_`date +%S`_`date +%d`_`date +%m`_`date +%Y`.tar"
    ruta2="backup_ruta2_`date +%H`_`date +%M`_`date +%S`_`date +%d`_`date +%m`_`date +%Y`.tar"
    
    # ● Variables para facer o tar que especifica onde se gardan os backup
    ruta_backup1="$ruta_destino/$ruta1"
    ruta_backup2="$ruta_destino/$ruta2"

    # ● If para comparar se o tamaño do directorio /var/log é superior ao tamaño máximo que é 20
    if [[ $tamanho_ruta1_KB -gt $tamanho_maximo ]] ;
    then
        # ● Tar para crear o backup
        tar -cvf $ruta_backup1 $ruta_var
    # ● Else para indicar que cando sexa menor ou igual a 20 se faga unha copia
    else
        cp -r $ruta_var $ruta_destino
    fi
    
    # ● If para comparar se o tamaño do directorio Descargas é superior ao tamaño máximo que é 20
    if [[ $tamanho_ruta2_KB -gt $tamanho_maximo ]] ;
    then
        # ● Tar para crear o backup
        tar -cvf $ruta_backup2 $ruta_descargas
    # ● Else para indicar que cando sexa menor ou igual a 20 se faga unha copia
    else
        cp -r $ruta_descargas $ruta_destino
    fi

}

# ● Comando para chamar á función
extraer_Tamanho

# ● Comando para que se abra o directorio onde se gardan os backups/copias
nautilus -w /home/marta/Descargas/backup