// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"

import { definitionsFromContext } from "stimulus/webpack-helpers"

import GradeController from "./grade_controller"
application.register('grade', GradeController)

