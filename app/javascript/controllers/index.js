// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"



import SubjectsController from "./subjects_controller"
application.register("subjects", SubjectsController)
