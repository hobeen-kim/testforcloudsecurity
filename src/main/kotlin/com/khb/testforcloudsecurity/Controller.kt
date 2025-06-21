package com.khb.testforcloudsecurity

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping

@Controller
class Controller {

    @GetMapping
    fun test1(): String {
        return "test"
    }

    @GetMapping("/test")
    fun test2(): String {
        return "test2"
    }
}