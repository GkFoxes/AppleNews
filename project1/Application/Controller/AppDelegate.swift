//
//  AppDelegate.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 16.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import RealmSwift

var realm : Realm!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 0.5)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let splitViewController = mainStoryboard.instantiateViewController(withIdentifier: "StartSplitViewController") as! UISplitViewController
        UIApplication.shared.keyWindow?.rootViewController = splitViewController

        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController

        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        
        let tabBarViewController = self.window!.rootViewController as! UITabBarController
        
        for viewController in tabBarViewController.viewControllers! {
            if viewController.title == "Detail" {
                _ = viewController as? UISplitViewController
            }
        }
        
        if !UserDefaults.standard.bool(forKey: "db_install") {
            self.girlInitial()
        }
        
        return true
    }
    
    func girlInitial() {
        let realmInstance = try! Realm()
        try! realmInstance.write {
            realmInstance.add(Girl(
                name: "Angelina Jolie",
                biography:
                """
                    Angelina Jolie (born Angelina Jolie Voight, June 4, 1975) is an American actress, filmmaker, and humanitarian. She has received an Academy Award, two Screen Actors Guild Awards, and three Golden Globe Awards, and has been cited as Hollywood's highest-paid actress. Jolie made her screen debut as a child alongside her father, Jon Voight, in Lookin' to Get Out (1982). Her film career began in earnest a decade later with the low-budget production Cyborg 2 (1993), followed by her first leading role in a major film, Hackers (1995). She starred in the critically acclaimed biographical cable films George Wallace (1997) and Gia (1998), and won an Academy Award for Best Supporting Actress for her performance in the drama Girl, Interrupted (1999).
                    Jolie's starring role as the video game heroine Lara Croft in Lara Croft: Tomb Raider (2001) established her as a leading Hollywood actress. She continued her successful action-star career with Mr. & Mrs. Smith (2005), Wanted (2008), and Salt (2010), and received critical acclaim for her performances in the dramas A Mighty Heart (2007) and Changeling (2008), which earned her a nomination for an Academy Award for Best Actress. Her biggest commercial success came with the fantasy picture Maleficent (2014). In the 2010s, Jolie expanded her career into directing, screenwriting, and producing, with In the Land of Blood and Honey (2011), Unbroken (2014), By the Sea (2015), and First They Killed My Father (2017).
                """,
                link: "https://en.wikipedia.org/wiki/Angelina_Jolie"))
            realmInstance.add(Girl(
                name: "Scarlett Johansson",
                biography:
                """
                    Scarlett Ingrid Johansson (born November 22, 1984) is an American actress and singer. She was among the world's highest-paid actresses from 2014 to 2016, has made multiple appearances in the Forbes Celebrity 100, and has a star on the Hollywood Walk of Fame. Born and raised in Manhattan, New York City, she aspired to be an actress from a young age, and first appeared on stage in an Off-Broadway play as a child. Johansson made her film debut in the fantasy comedy North (1994) and was nominated for an Independent Spirit Award for Manny & Lo (1996). She gained further recognition for her work in The Horse Whisperer (1998) and Ghost World (2001).
                    Johansson shifted to adult roles in 2003 with her performances in Lost in Translation (for which she won a BAFTA Award for Best Actress) and Girl with a Pearl Earring. She was nominated for four Golden Globe Awards for these films, and for playing an estranged teenager in the drama A Love Song for Bobby Long (2004), and a seductress in the psychological thriller Match Point (2005). Other films during this period include the mystery thriller The Prestige (2006) and the comedy-drama Vicky Cristina Barcelona (2008). She also released two albums: Anywhere I Lay My Head (2008) and Break Up (2009), both of which charted on the Billboard 200.
                """,
                link: "https://en.wikipedia.org/wiki/Scarlett_Johansson"))
            realmInstance.add(Girl(
                name: "Megan Fox",
                biography:
                """
                    Megan Denise Fox (born May 16, 1986) is an American actress and model. She began her acting career in 2001, with several minor television and film roles, and played a regular role on the Hope & Faith television sitcom. In 2004, she made her film debut with a role in the teen comedy Confessions of a Teenage Drama Queen. In 2007, she co-starred as Mikaela Banes, the love interest of Shia LaBeouf's character, in the blockbuster action film Transformers, which became her breakout role. Fox reprised her role in the 2009 sequel, Transformers: Revenge of the Fallen. Later in 2009, she starred as the eponymous lead in the black comedy horror film Jennifer's Body. In 2014, Fox starred as April O'Neil in Teenage Mutant Ninja Turtles, and reprised the role in Teenage Mutant Ninja Turtles: Out of the Shadows (2016).
                    Fox is considered one of the modern female sex symbols and has appeared in magazines such as Maxim, Rolling Stone and FHM.
                """,
                link: "https://en.wikipedia.org/wiki/Megan_Fox"))
            realmInstance.add(Girl(
                name: "Charlize Theron",
                biography:
                """
                  Charlize Theron (born 7 August 1975) is a South African and American actress and film producer. She is known for starring in numerous Hollywood films, such as The Devil's Advocate (1997), Mighty Joe Young (1998), The Cider House Rules (1999), Monster (2003), The Italian Job (2003), Hancock (2008), The Road (2009), Snow White and the Huntsman (2012), Prometheus (2012), A Million Ways to Die in the West (2014), Mad Max: Fury Road (2015), The Fate of the Furious (2017), Atomic Blonde (2017) and Tully (2018).
                  Theron received critical acclaim for her portrayal of serial killer Aileen Wuornos in Monster, for which she won the Academy Award, Silver Bear, Golden Globe Award, and Screen Actors Guild Award for Best Actress, among other accolades, becoming the first South African to win an Academy Award in a major acting category. She received Academy Award and Golden Globe Award nominations for her performance in the sexual harassment-themed drama North Country (2005), and a Golden Globe Award nomination for her performance in Jason Reitman's film Young Adult (2011).
                """,
                link: "https://en.wikipedia.org/wiki/Charlize_Theron"))
            realmInstance.add(Girl(
                name: "Monica Bellucci",
                biography:
                """
                  Monica Anna Maria Bellucci (born 30 September 1964) is an Italian actress and model. Bellucci began her career as a fashion model, modeling for the likes of Dolce & Gabbana and Dior, before making a transition to Italian films and later Hollywood films. She is often considered among the most beautiful women in the world.
                   She perhaps best known to American audiences for her role as Persephone in the 2003 science-fiction films The Matrix Reloaded and The Matrix Revolutions. She also played the Bride of Dracula in Francis Ford Coppola's gothic romance film Bram Stoker's Dracula (1992) and Malèna Scordia in the Italian-language romantic drama Malèna (2000), and was in the controversial Gaspar Noé arthouse horror film Irréversible (2002), and Mel Gibson's biblical drama The Passion of the Christ (2004), in which she portrayed Mary Magdalene. At age 51, Bellucci played the role of a Bond girl in the 2015 James Bond film Spectre.
                """,
                link: "https://en.wikipedia.org/wiki/Monica_Bellucci"))
            realmInstance.add(Girl(
                name: "Natalie Portman",
                biography:
                """
                  Natalie Portman (born June 9, 1981) is an actress, film producer and director with dual Israeli and American citizenship. Portman is best known for her roles as Padmé Amidala in the Star Wars prequel trilogy and Nina Sayers in Black Swan (2010); she won an Academy Award, Golden Globe Award, and Screen Actors Guild Award, among other accolades, for her performance in the latter.
                  Portman made her feature film debut in Léon: The Professional (1994), which co-starred Jean Reno and Gary Oldman. At the same time, she studied dancing and acting in New York, and starred in Star Wars: Episode I – The Phantom Menace (1999) while still attending high school in Long Island. In 1999, Portman enrolled at Harvard University to study psychology, alongside her work as an actress; she completed a bachelor's degree in 2003. During her studies, she starred in Star Wars: Episode II – Attack of the Clones (2002) and opened in New York City's The Public Theater production of Anton Chekhov's The Seagull in 2001. The Star Wars prequel trilogy concluded with Star Wars: Episode III – Revenge of the Sith (2005).
                """,
                link: "https://en.wikipedia.org/wiki/Natalie_Portman"))
            realmInstance.add(Girl(
                name: "Mila Kunis",
                biography:
                """
                    Milena Markovna "Mila" Kunis (born August 14, 1983) is an American actress. In 1991, at the age of seven, she moved from Soviet Ukraine to the United States with her family. After being enrolled in acting classes as an after-school activity, she was soon discovered by an agent. She appeared in several television series and commercials, before acquiring her first significant role at age 14, playing Jackie Burkhart on the television series That '70s Show (1998–2006). Since 1999, she has voiced Meg Griffin on the animated series Family Guy.
                    Kunis' breakout film role came in 2008,playing Rachel in the romantic comedy Forgetting Sarah Marshall. She gained further critical acclaim and accolades for her performance in the psychological thriller Black Swan (2010), for which she received the Marcello Mastroianni Award for Best Young Actor or Actress, and nominations for the SAG Award and the Golden Globe Award for Best Supporting Actress. Her other major films include the neo-noir action film Max Payne (2008), the post-apocalyptic action film The Book of Eli (2010), the romantic comedy film Friends with Benefits (2011), the comedy film Ted (2012), the fantasy film Oz the Great and Powerful (2013) as the Wicked Witch of the West, and the comedy film Bad Moms (2016).
                """,
                link: "https://en.wikipedia.org/wiki/Mila_Kunis"))
            realmInstance.add(Girl(
                name: "Keira Knightley",
                biography:
                """
                    Keira Christina Knightley, OBE (born 26 March 1985) is an English actress. Having worked extensively in both the British and the American film Industries, she has won an Empire Award and multiple nominations for the British Academy, the Golden Globe, and the Academy Awards. Knightley featured as the highest-paid English actress on Forbes Celebrity 100 in 2008. Apart from acting in films, she had also starred in Broadway and West End Theatre productions.
                    Knightley began acting as a child on television and made her feature film debut in 1995; she ventured into such supporting roles as Sabé in Star Wars: Episode I – The Phantom Menace (1999) and Frankie Smith in the psychological horror film The Hole (2001). She made her breakthrough with the 2002 film Bend It Like Beckham, and achieved international fame in 2003 after playing Elizabeth Swann in the $4.5 billion grossing Pirates of the Caribbean film series. The 2005 romance film Pride & Prejudice marked a significant turning point in Knightley's career; her portrayal of Elizabeth Bennet earned her critical acclaim and a Best Actress nomination at the Academy Awards. She later became known for her roles as the heroines of other such period dramas as the 2007 productions Atonement and Silk and the 2012 release Anna Karenina.
                """,
                link: "https://en.wikipedia.org/wiki/Keira_Knightley"))
            realmInstance.add(Girl(
                name: "Jennifer Lawrence",
                biography:
                """
                   Jennifer Shrader Lawrence (born August 15, 1990) is an American actress. Her films have grossed over $5.5 billion worldwide, and she was the highest-paid actress in the world in 2015 and 2016. She appeared in Time's 100 most influential people in the world in 2013 and in the Forbes Celebrity 100 in 2014 and 2016.
                   During her childhood, Lawrence performed in church plays and school musicals. At age 14, Lawrence was in New York City when a talent scout spotted her. She then moved to Los Angeles and began her acting career by playing guest roles in television shows. Her first major role came as a main cast member on the sitcom The Bill Engvall Show (2007–2009). Lawrence made her film debut in a supporting role in Garden Party (2008), and had her breakthrough playing a poverty-stricken teenager in the independent drama Winter's Bone (2010). She achieved wider recognition for starring as the mutant Mystique in X-Men: First Class (2011), a role she reprised in later installments of the series.
                """,
                link: "https://en.wikipedia.org/wiki/Jennifer_Lawrence"))
            realmInstance.add(Girl(
                name: "Margot Robbie",
                biography:
                """
                  Margot Elise Robbie (born 2 July 1990)is an Australian actress and film producer. In 2017, Time magazine named her as one of the 100 most influential people in the world and Forbes featured her in their 30 Under 30 list.
                  Born and raised on a farm in Dalby, Queensland, Robbie studied drama at Somerset College. She began her career in Australian independent films in the late 2000s, before working in the soap opera Neighbours (2008–2011), which earned her two Logie Award nominations. After moving to the United States, she starred in the short-lived ABC drama series Pan Am (2011–2012). In 2013, she had a supporting role in the romantic comedy About Time, and made her breakthrough later that year by co-starring in Martin Scorsese's biographical black comedy The Wolf of Wall Street.
                """,
                link: "https://en.wikipedia.org/wiki/Margot_Robbie"))
        }
        UserDefaults.standard.set(true, forKey: "db_install")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? StartDetailViewController else { return false }
        if topAsDetailController.girlName == "" {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
           return true
        }
        return true
    }
}
