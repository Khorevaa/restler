#Использовать asserts
#Использовать "../src"

Функция ПолучитьСписокТестов(МенеджерТестирования) Экспорт
    
    МассивТестов = Новый Массив;
    МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетМетодGET");
    МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетУстановкаЗаголовков");
    
    Возврат МассивТестов;
    
КонецФункции

Процедура ТестДолжен_ПроверитьЧтоРаботаетМетодGET() Экспорт

	Перем ЗаглушкаСоединения;
	ЗаглушкаСоединения = ЗагрузитьСценарий(ОбъединитьПути(ТекущийСценарий().Каталог, "ЗаглушкаСоединения.os"));

	ЗаглушкаСоединения.УстановитьОжидаемыйОтвет("{""prop"": ""testvalue""}");

	Клиент = Новый КлиентВебAPI();
	Клиент.ИспользоватьСоединение(ЗаглушкаСоединения);

	Документ = Клиент.Получить("/point/document");

	Ожидаем.Что(Документ).ИмеетТип("Соответствие");
	Ожидаем.Что(Документ["prop"]).Равно("testvalue");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетУстановкаЗаголовков() Экспорт
	
	Клиент = Новый КлиентВебAPI();
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Test", "Value");
	Клиент.УстановитьЗаголовки(Заголовки);
	Запрос = Клиент.ПолучитьHTTPЗапрос("/test");

	Ожидаем.Что(Запрос.Заголовки["Test"], "Value");

КонецПроцедуры