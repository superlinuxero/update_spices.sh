#!/usr/bin/bash

if [ "$XDG_CURRENT_DESKTOP" = "X-Cinnamon" ]; then

	if nc -zw1 google.com 443  ; then

		positivo=""

		for tipo in applet extension theme desklet; do
		positivo=$positivo$(cinnamon-spice-updater --list-simple $tipo)	
		done

		if [ -n "$positivo" ] ; then
			zenity --notification --icon="info" \
        		--text="Actualizando Especias"
			echo "Actualizando Especias reinicio cinnamon"
 			cinnamon-spice-updater --update-all
			sleep 6
			dbus-send --type=method_call --print-reply --dest=org.Cinnamon \
			/org/Cinnamon org.Cinnamon.Eval string:'global.reexec_self()' > /dev/null
		else
#			zenity --notification --icon="info" \
#        		--text="No hay actualizaciones de Especias de Cinnamon"
			echo "Las Especias Están Frescas"
		fi
	fi
echo "Ejecutado el `date`" >> /tmp/update_spices.log
fi

