# athome_hardware

## Descrição: 

Esse repertório é referente a inicialização do controle e de todo hardware do rôbo - sensores(lidar 2D, realsense, odometria, imu) e gimbals(versão sem o manipulador, apenas regulador da realsense) - não inclui a inicialização das rodas.

## Conteúdo:

Submódulos: 

* [athome_description](https://github.com/Pequi-Mecanico-Home/athome_description) - utilizado para extrair o URDF do rôbo e publicar as TFs do robo
* [rplidar_ros](https://github.com/Pequi-Mecanico-Home/rplidar_ros/tree/7b011f142b489d448492b5e6a683293f1e482aaa) - utilizado para iniciar o nó do lidar 2d

Módulos:

* athome_teleop - utilizado para iniciar o telop - Teclado e Controle Ps4-.
* athome_hardware - utilizado para dar launch em todos pacotes fundamentais.
* serial_sensors - utilizado para iniciar nó da odometria, imu e gimbals

## Comandos:

Comando Docker:

Comando do pacote:
