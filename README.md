# Un script bash que realice un backup de varios directorios completos y otro que más tarde los elimine.

Las rutas de los directorios de los cuales se hace el backup son:

Ruta 1 → /var/log/

Ruta 2 → /home/user/Downloads

En el primer script se utilizará el comando du -sh para comprobar que el directorio tiene un tamaño >20kB para realizar la compresión, sino es mayor se utilizará el cp para copiar el directorio. Para comprobar el tamaño se creara una función.

Al final del programa se tiene que abre el explorador de archivos Nautilus en la ruta de destino → home/user/Downloads/backup

En el segundo script se creará una función para borrar los backups y las copias.

Se utilizará el crontab para a ejecución programada de los dos scripts:

El de realización de los backup → Cada 2 minutos

El de eliminación de los backup → Cada 3 minutos
