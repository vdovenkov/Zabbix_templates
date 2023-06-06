$template_header = @"
zabbix_export:
  version: '6.0'
  date: '{0}'
  groups:
    - uuid: {1}
      name: Templates
  templates:
    - uuid: {2}
      template: 'UPS APC'
      name: 'UPS APC'
      groups:
        - name: Templates
      items:

"@

$template_body = @"
        - uuid: {0}
          name: '{1}'
          key: ups.apc["{2}"]
          delay: 1m
          value_type: TEXT
          description: {1}
          request_method: POST
          tags:
            - tag: Application
              value: APCUPSd

"@

$params = @{
    "DATE"      = "Время последнего опроса ИБП";
    "HOSTNAME"  = "Имя сервера мониторинга";
    "VERSION"   = "Версия apcupsd";
    "UPSNAME"   = "Имя ИБП из EEPROM";
    "CABLE"     = "Тип кабеля";
    "DRIVER"    = "Тип ИБП";
    "UPSMODE"   = "Режим работы apcupsd";
    "STARTTIME" = "Время запуска apcupsd";
    "MODEL"     = "Модель ИБП";
    "STATUS"    = "Текущее состояние ИБП";
    "LINEV"     = "Напряжение на входе ИБП";
    "LOADPCT"   = "Уровень нагрузки ИБП";
    "BCHARGE"   = "Процент заряда батарей";
    "TIMELEFT"  = "Расчетное время остаточной работы";
    "MBATTCHG"  = "Минимальный процент заряда для отключения оборудования";
    "MINTIMEL"  = "Минимальное время работы для отключения оборудования";
    "MAXTIME"   = "Макимальное время работы для отключеня оборудования";
    "MAXLINEV"  = "Максимальное напряжение входа";
    "MINLINEV"  = "Минимальное напряжение входа";
    "OUTPUTV"   = "Напряжение на выходе ИБП";
    "SENSE"     = "Чуствительность к входному напряжению";
    "DWAKE"     = "Задержка включения после востановления питания";
    "DSHUTD"    = "Задержка отключения оборудования";
    "DLOWBATT"  = "Оставшшееся время для аварийного отключения";
    "LOTRANS"   = "Минимальное напряжение для переключения на батареи";
    "HITRANS"   = "Максимальное напряжение для перключения на батареи";
    "RETPCT"    = "Процент заряда батарей для включения оборудования";
    "ITEMP"     = "Внутренняя температура ИБП";
    "ALARMDEL"  = "Период задержки аварийного сигнала ИБП";
    "BATTV"     = "Зарядное напряжение батареи";
    "LINEFREQ"  = "Частота севого напряжения";
    "LASTXFER"  = "Причина последнего переключения на батареи";
    "NUMXFERS"  = "Количество переключений на батареи с момента запуска apcupsd";
    "TONBATT"   = "Время в секундах работы от батарей";
    "CUMONBATT" = "Общее время работы от батарей в секундах с момента запуска apcupsd";
    "XOFFBATT"  = "Время и дата последнего перевода с батарей";
    "SELFTEST"  = "Результат самотестирования";
    "STESTI"    = "Интервал в часах между автоматическими самопроверками";
    "STATFLAG"  = "HEX STATUS";
    "DIPSW"     = "Настройки DIP-переключателя";
    "REG1"      = "Значения неисправностей 1";
    "REG2"      = "Значения неисправностей 2";
    "REG3"      = "Значения неисправностей 3";
    "MANDATE"   = "Дата изготовления ИБП";
    "SERIALNO"  = "Серийный номер";
    "BATTDATE"  = "Дата последней замены батарей";
    "NOMOUTV"   = "Номинальное выходное напряжение";
    "NOMBATTV"  = "Номинальное напряжение батареи";
    "EXTBATTS"  = "Количество внешних батарей";
    "BADBATTS"  = "Количество неисправных батарейных блоков";
    "FIRMWARE"  = "Номер версии прошивки";
    "END_APC"   = "Время отчета STATUS"
}

$now = Get-Date -UFormat "%FT%TZ"
$message = $template_header -f $now, ([guid]::NewGuid().ToString()).Replace("-", ""), ([guid]::NewGuid().ToString()).Replace("-", "")
$params.GetEnumerator() | ForEach-Object {
    $uuid = ([guid]::NewGuid().ToString()).Replace("-", "")
    $message += $template_body -f $uuid, $_.value, $_.key
}
Clear-Host
Out-File -FilePath 'C:\tmp\template.yaml' -InputObject $message