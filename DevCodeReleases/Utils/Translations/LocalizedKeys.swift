import Foundation
import SwiftUI

// swiftlint: disable line_length
enum LocalizedKeys {
    enum Details {
		static let sidemenuMenu: LocalizedStringKey = "Details_sidemenu_menu" // Menu
		static let sidemenuAboutSymbols: LocalizedStringKey = "Details_sidemenu_about_symbols" // A cerca de la simbología
		static let sidemenuIconMean: LocalizedStringKey = "Details_sidemenu_icon_mean" // ¿Qué significa cada icono?
		static let iconDate: LocalizedStringKey = "Details_icon_date" // Indica la fecha en la que se ha publicado la versión
		static let iconBuild: LocalizedStringKey = "Details_icon_build" // Indica la 'build' de la versión
		static let iconIos: LocalizedStringKey = "Details_icon_ios" // Indica la versión de iOS a la cual se da soporte en la version
		static let iconMac: LocalizedStringKey = "Details_icon_mac" // Indica la versión de macOS a la cual se da soporte en la version
		static let iconTv: LocalizedStringKey = "Details_icon_tv" // Indica la versión de tvOS a la cual se da soporte en la version
		static let iconWatch: LocalizedStringKey = "Details_icon_watch" // Indica la versión de watchOS a la cual se da soporte en la version
		static let iconSwift: LocalizedStringKey = "Details_icon_swift" // Indica la versión de Swift que incluye la version
		static let releaseDate: LocalizedStringKey = "Details_release_date" // Fecha de publicación
		static let otherInfo: LocalizedStringKey = "Details_other_info" // Otra información
		static let requires: LocalizedStringKey = "Details_requires" // Requiere
		static let realeaseNotesButton: LocalizedStringKey = "Details_realease_notes_button" // Abrir las notas de la versión
	}

    enum Menu {
		static let differencesMenu: LocalizedStringKey = "Menu_differences_menu" // ¿Cuáles son las diferencias entre las versiones?
		static let realaseExplanation: LocalizedStringKey = "Menu_realase_explanation" // Una versión de lanzamiento (Release) es una versión de un software, producto o servicio que se considera estable y apta para ser utilizada por el público en general. Esta versión generalmente ha pasado por un proceso de desarrollo completo, pruebas exhaustivas y corrección de errores, y se considera adecuada para su distribución y uso en producción.
		static let rcExplanation: LocalizedStringKey = "Menu_rc_explanation" // Una versión candidata a lanzamiento (Release Candidate o RC) es una versión que se encuentra en una etapa avanzada de desarrollo y se considera casi lista para ser lanzada como versión de lanzamiento. El propósito principal de una versión candidata a lanzamiento es recopilar comentarios finales de los usuarios y realizar pruebas adicionales para asegurarse de que no haya problemas críticos antes de su lanzamiento oficial. Si no se encuentran errores importantes durante esta etapa, la versión candidata a lanzamiento puede convertirse en la versión de lanzamiento final.
		static let betaExplanation: LocalizedStringKey = "Menu_beta_explanation" // Una versión beta (Beta) es una versión preliminar de un software, producto o servicio que se pone a disposición de un grupo limitado de usuarios para su evaluación y prueba. Las versiones beta se lanzan con el objetivo de recopilar comentarios, identificar problemas y realizar mejoras antes de la versión de lanzamiento. Estas versiones a menudo contienen características nuevas y aún pueden contener errores conocidos o problemas de rendimiento. Los usuarios de las versiones beta suelen ser invitados o voluntarios que brindan retroalimentación a los desarrolladores para ayudar a mejorar la calidad del producto antes de su lanzamiento oficial.
	}

    enum Home {
		static let search: LocalizedStringKey = "Home_search" // Buscar por número de versión
	}

    enum Favourites {
		static let favouritesEmpty: LocalizedStringKey = "Favourites_favourites_empty" // No tienes versiones favoritas actualmente
		static let favouritesTitle: LocalizedStringKey = "Favourites_favourites_title" // Versiones favoritas
		static let favouritesInstructions: LocalizedStringKey = "Favourites_favourites_instructions" // Para añadir versiones, desliza de derecha a izquierda en el listado principal
	}

    enum Onboarding {
		static let onboardingTitle1: LocalizedStringKey = "Onboarding_onboarding_title1" // Todas las versiones disponibles
		static let onboardingSubtitle1: LocalizedStringKey = "Onboarding_onboarding_subtitle1" // Con todos los detalles, siempres disponibles para que los puedas consultar
		static let onboardingTitle2: LocalizedStringKey = "Onboarding_onboarding_title2" // Guarda tus verisones favoritas
		static let onboardingSubtitle2: LocalizedStringKey = "Onboarding_onboarding_subtitle2" // Y consúltalas siempre que lo necesites, siempre en la palma de tu mano
		static let onboardingTitle3: LocalizedStringKey = "Onboarding_onboarding_title3" // Personaliza tu experiencia de usuario
		static let onboardingSubtitle3: LocalizedStringKey = "Onboarding_onboarding_subtitle3" // Ajusta la aplicación a tu medida: filtra, busca y guarda tus versiones favoritas para acceder rápidamente a la información que necesitas
	}
}
// swiftlint: enable line_length
