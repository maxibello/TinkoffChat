//
//  TestData.swift
//  TinkoffChat
//
//  Created by MacBookPro on 09/03/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation

class TestData {
//    static let conversations: [Conversation] = [
//        Conversation(
//            online: true,
//            hasUnreadMessages: true,
//            name: "Катеринка",
//            message: "Ты уже забронировал столик?",
//            date: modifyDate(byAdding: .minute, value: -5, to: Date())),
//        Conversation(
//            online: true,
//            hasUnreadMessages: false,
//            name: "Братишка",
//            message: "Вай-вай, брат",
//            date: modifyDate(byAdding: .hour, value: -1, to: Date())),
//        Conversation(
//            online: true,
//            hasUnreadMessages: false,
//            name: "Толя Сиплый",
//            message: nil,
//            date: nil),
//        Conversation(
//            online: true,
//            hasUnreadMessages: true,
//            name: "Яків Шевченко",
//            message: "Як справи росіянин?",
//            date: modifyDate(byAdding: .minute, value: -45, to: Date())),
//        Conversation(
//            online: true,
//            hasUnreadMessages: true,
//            name: "Подруга Детства",
//            message: "Превед, давно не виделись, настало время возвращать старые долги...",
//            date: modifyDate(byAdding: .minute, value: -22, to: Date())),
//        Conversation(
//            online: true,
//            hasUnreadMessages: true,
//            name: "Hydгa Un1on",
//            message: "So1i 111iksy $Pais'ы",
//            date: modifyDate(byAdding: .day, value: -10, to: Date())),
//        Conversation(
//            online: true,
//            hasUnreadMessages: false,
//            name: "Серега (100 рублей)",
//            message: "Вано дарофф у меня к тебе маленькая просьба",
//            date: modifyDate(byAdding: .day, value: -3, to: Date())),
//        Conversation(
//            online: true,
//            hasUnreadMessages: false,
//            name: "Мама",
//            message: "Кому-то пора вылезать из мокрых штанишек и брать ответственность на себя",
//            date: modifyDate(byAdding: .minute, value: -10, to: Date())),
//        Conversation(
//            online: true,
//            hasUnreadMessages: true,
//            name: "Вика препод (skyeng)",
//            message: "Hi Max! Can we reshedule our next lesson?",
//            date: modifyDate(byAdding: .minute, value: -15, to: Date())),
//        Conversation(
//            online: true,
//            hasUnreadMessages: false,
//            name: "Ангелина Сергеевна Марцинкевич",
//            message: nil,
//            date: nil),
//        Conversation(
//            online: false,
//            hasUnreadMessages: false,
//            name: "Олег Семенов",
//            message: "Я когда в первый раз ее увидел, первая мысль была: Опять?!?!",
//            date: modifyDate(byAdding: .hour, value: -5, to: Date())),
//        Conversation(
//            online: false,
//            hasUnreadMessages: false,
//            name: "Борис Альбертович (Насяльника)",
//            message: "Ты где",
//            date: Date()),
//        Conversation(
//            online: false,
//            hasUnreadMessages: false,
//            name: "Ahmed Baroev",
//            message: nil,
//            date: nil),
//        Conversation(
//            online: false,
//            hasUnreadMessages: true,
//            name: "Юля Тиндер",
//            message: "Когда мы идем в ЗАГС?! 💋💋",
//            date: modifyDate(byAdding: .day, value: -4, to: Date())),
//        Conversation(
//            online: false,
//            hasUnreadMessages: false,
//            name: "Вячеслав Всеволодович Полоскун",
//            message: "Иван Анатольевич, мое почтение, милейший человек!",
//            date: modifyDate(byAdding: .day, value: -30, to: Date())),
//        Conversation(
//            online: false,
//            hasUnreadMessages: false,
//            name: "Отец",
//            message: "Не забудь полить помидоры на участке!!!",
//            date: modifyDate(byAdding: .minute, value: -33, to: Date())),
//        Conversation(
//            online: false,
//            hasUnreadMessages: false,
//            name: "Егор Палыч (сосед)",
//            message: "Привет мы подписываем коллективное обращение в суд по поводу соседки с 1го этажа",
//            date: modifyDate(byAdding: .minute, value: -50, to: Date())),
//        Conversation(
//            online: false,
//            hasUnreadMessages: false,
//            name: "Алексей Литвинов",
//            message: nil,
//            date: nil),
//        Conversation(
//            online: false,
//            hasUnreadMessages: false,
//            name: "Юлия Потапчук",
//            message: nil,
//            date: nil),
//        Conversation(
//            online: false,
//            hasUnreadMessages: true,
//            name: "Кристина Пустырникова",
//            message: "Иван, доброго времени суток! Я HR агентства \"Brilliant Staffchik\" я хочу с вами связаться",
//            date: modifyDate(byAdding: .minute, value: -10, to: Date())),
//    ]
    
    static let messages: [Message] = [
    Message(isIncoming: true, text: "😂"),
    Message(isIncoming: false, text: "Как житуха, братуха? Чо-как???"),
    Message(isIncoming: true,
                text: "Когда ты в первый раз украла деньги, я тебя простил, но сейчас ты сделала это вновь, если я не увижу этих денег у себя на столе завтра, пишу заявление в полицию. Да, так делают взрослые люди, ты же хотела стать взрослой? Если ты моя дочь, это не значит, что меня можно так нагло грабить, я не таков!!"),
    Message(isIncoming: false, text: "Печаль, согласно стоикам, многообразна. Она может вызываться состраданием, завистью, ревностью, недоброжелательством, беспокойством, горем и т. д. Страх стоики рассматривали как предчувствие зла. Вожделение они понимали как неразумное стремление души. Удовольствие воспринималось стоиками как что..."),
    Message(isIncoming: true, text: "Как твои дела? Все равно, знаешь..."),
    Message(isIncoming: false, text: "Печаль, согласно стоикам, многообразна. Она может вызываться состраданием, завистью, ревностью, недоброжелательством, беспокойством, горем и т. д. Страх стоики рассматривали как предчувствие зла. Вожделение они понимали как неразумное стремление души. Удовольствие воспринималось стоиками как что..."),
    Message(isIncoming: true, text: "Как жизнь, дорогой? Как семья???"),
    Message(isIncoming: false, text: "😎")
    ]

}

