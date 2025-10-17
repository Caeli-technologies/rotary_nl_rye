using System.Collections.Generic;
using RotaryYepNL.Models;

namespace RotaryYepNL.Data;

public static class ContactsData
{
    public static List<ContactSection> GetSections()
    {
        var mdjc = new ContactSection { Id = "mdjc", Title = "MDJC" };

        mdjc.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Barbara Tusveld",
            Bio = @"Als voorzitter van de Rotary Youth Exchange Nederlands ben ik enorm trots dat we met ons team elk jaar 30-40 longterm studenten, 10-15 Shorterm exchangers en veel scholieren die onze buitenlandse kampen bezoeken en onze Summercamps die georganiseerd worden door Nederlandse Rotary clubs voor buitenlandse scholieren.

Het is een ""lifetime in a year"" en een geweldige mooie ervaring. Zelf ben ik op exchange geweest in Amerika, al weer een ""tijdje"" geleden. Nog steeds ga ik jaarlijks naar mijn stadje terug. Het is een tweede thuis.

Onze kinderen zijn beiden op uitwisseling geweest en ook zijn we bonusouder van veel buitenlandse scholieren geweest waar we een hele fijne band mee hebben opgebouwd.

Al ruim 10 jaar ben ik betrokken bij dit mooie programma en geniet van ons team en wat we voor een grote groep scholieren kunnen betekenen.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/barbara-tusveld.jpg",
            Email = "chair@rotaryyep.nl",
            PhoneNumber = "+31655128529",
            Club = "RC Lelystad",
            District = "1590 NOORD-NEDERLAND",
            Functions = new List<string> { "Chair" }
        });

        mdjc.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Clasine Scheepers",
            Bio = @"Sinds 2017 ben ik lid van team Longterm. Ongelofelijk leuk om Nederlandse jongeren te begeleiden in hun avontuur voor jaaruitwisseling en om buitenlandse jongeren vervolgens hier in Nederland te ontvangen die een jaar lang worden ondergedompeld in hagelslag, stroopwafels en (het aller moeilijkst) de Nederlandse taal. Zo gaaf om dit elke keer met ons team te organiseren en te regelen. Begin 2021 ben ik secretaris MDJC – weer een nieuwe avontuur.

In mijn familie zijn er velen inmiddels op exchange geweest waaronder mijn man en dochter. Een van de gastgezinnen uit Amerika bezoeken we nog jaarlijks. Je krijgt er echt een nieuwe familie bij. Zelf hebben we nu drie keer een exchange student in huis gehad. Dan merk je van dichtbij waar ze tegenaan lopen in een nieuwe omgeving, andere cultuur en met een vreemde taal. Fijn om hen te helpen hun weg te vinden, een verrijking van je eigen leven.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/clasine-schepers.png",
            Email = "longtermin@rotaryyep.nl",
            PhoneNumber = "+31652710977",
            Club = "RC Huizen",
            District = "1570 MIDDEN-NEDERLAND",
            Functions = new List<string> { "Secretaris MDJC" }
        });

        mdjc.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Evert Marseille",
            Bio = @"Sinds 1988 ben ik Rotary lid en ondanks mijn gevorderde leeftijd ben ik in juni 2023 door mijn clubgenoot Barbara gevraagd om penningmeester te worden. Bestuurlijk bezig zijn is mij met de paplepel ingegoten, dus ik vind het een hele eer om als oudje bezig te kunnen zijn met de ontwikkeling van jonge mensen die door een uitwisseling levenservaring kunnen opdoen.

In mijn actieve beroepsperiode was ik accountant en heb ik ook nog 20 jaar deel uitgemaakt van de Lelystadse gemeenteraad.

Ik ben gehuwd en heb 3 kinderen en 6 kleinkinderen. Wij hebben zelf ook veel mooie reizen gemaakt en daarmee ervaren hoe belangrijk het is om te zien hoe het leven in geheel andere landen is.
Helaas is dit door de ziekte van mijn echtgenote niet meer mogelijk. Alle reden voor mij om mij naast mijn taak als mantelzorger ook op bestuurlijk gebied in te zetten.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/evert-marseille.jpg",
            Email = "finance@rotaryyep.nl",
            PhoneNumber = string.Empty,
            Club = "RC Lelystad",
            District = "1590 Noord Nederland",
            Functions = new List<string> { "Penningmeester" }
        });

        mdjc.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Marga Oosterveld",
            Bio = @"Hallo, ik ben een oud uitwisselingsstudent of exchangee zoals dat heet. In het jaar 1988 - 1989 ben ik met Rotary een jaar naar het buitenland geweest. ""Class of 89"" noemen ze dat in Amerika. Eigenlijk wilde ik graag naar het noordoosten, maar ik kwam terecht in het zuidwesten van de USA. Totaal anders dan Nederland met indianen en cowboys, midden in de woestijn en in de bergen. Het is niet altijd makkelijk en soms best wel even slikken, maar als je dat lukt, heb je de tijd van je leven. Nu ben ik contactpersoon tussen de districten in de USA, Canada en Zuid Afrika om Rotary Clubs te vinden die willen uitwisselen met Nederland voor a lifetime in a year !!",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/marga-oosterveld.jpg",
            Email = "marga_bart@yahoo.com",
            PhoneNumber = "+31629586813",
            Club = "Rotary Club Oosterwolde",
            District = "1590 NOORD-NEDERLAND",
            Functions = new List<string> { "Longterm Chair", "Coördinator Amerika, Canada, Azië en Europa" }
        });

        mdjc.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Ernst Ziengs",
            Bio = @"Mijn naam is Ernst Ziengs. 53 jaar oud en woon in Weert samen met mijn vrouw Ellen en onze zonen Tijn (16) en Vigo. Ben ongeveer 10 jaar lid van Rotary Weert-Land van Horne. Daar ook voorzitter geweest en via Rotary en rechtstreeks doe ik veel vrijwilligerswerk. Zes jaar geleden heb ik wat tegenslag gehad met mijn gezondheid. Gevolg is dat ik opnieuw moest leren spreken, lopen en veel dingen opnieuw moest leren doen. In dit ""terug komen"" ben ik enorm geholpen door mijn gezin, vrienden en familie. Bij al die hulpvaardige mensen horen ook zeker mensen van de Rotary.

In mijn wil terug te komen in het leven speelt jeugd een voorname rol. Ik werk 2 dagen per week bij Fontys in Eindhoven. Jonge mensen iets proberen over te dragen kennis en vaardigheden houdt mijzelf ook jong en actief in deze tijd. Precies mijn ambitie als DJC van district 1550.

Naast de Exchanges is de vijfde Avenue Jeugd één van de leukste en meest uitgebreide Avenues. Als DJC mag ik deze ook, samen met alle clubs en regio's tot een succes proberen te maken!",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/ernst-ziengs.jpeg",
            Email = "youth@rotary-d1550.org",
            PhoneNumber = string.Empty,
            Club = "RC Weert-Land van Horne",
            District = "1550",
            Functions = new List<string> { "DJC 1550" }
        });

        mdjc.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Steven Stolp",
            Bio = @"Als scholier had ik geen flauw benul van het bestaan van uitwisselingen. In mijn studententijd heb ik dat ingehaald door mijn eigen exchanges te organiseren, (korter) werken en later studeren in (zuid) Frankrijk en vervolgens langer naar Ouagadougou in Burkina Faso, West-Afrika. Buiten de Nederlandse context ontwikkel je je net wat anders. Dat gun ik iedereen, en de wereld.

In het dagelijks leven werk ik in de gezondheidszorg als bedrijfskundige in verschillende rollen. De ""net iets andere blik"" komt daar van pas. Daarnaast sport ik graag en volgens sommigen veel, het liefst met gezinsleden of vrienden.

In mijn vrije tijd wil ik vooral met plezier aan leuke dingen bijdragen. Daarom ben ik van ""de activiteiten"". Met het team van de long term exchange, Rotex (oud exchangestudenten) en de uitwisselingsstudenten ondernemen we samen van alles. Daarbij hebben we lol en leren we elke dag weer van alles van elkaar.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/steven-stolp.png",
            Email = "DJC1560@rotaryyep.nl",
            PhoneNumber = string.Empty,
            Club = "RC Bennekom",
            District = "1560 OOST-NEDERLAND",
            Functions = new List<string> { "DJC1560" }
        });

        mdjc.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Erna van Dijk",
            Bio = @"Ik ben Erna van Dijk. Sinds 2013 ben ik lid van de Rotary en sinds 1 juli 2023 District Jeugd Commissaris van D1570. In 1987-88 heb ik zelf meegedaan aan een uitwisselingsprogramma en heb ik een jaar in El Paso, Texas gewoond. Ik heb dit als een hele waardevolle periode ervaren en wil graag mijn steentje bijdragen om jongeren ook een fantastische buitenland ervaring te laten hebben.

In het dagelijks leven ben ik werkzaam als bedrijfsarts. Ik woon samen met mijn vriend, mijn zoon en zijn zoon en 2 dochters. Een samengesteld gezin dus.

Rotary is mijn grootste hobby, maar daarnaast ben ik ook lid van toastmasters. Verder vul ik mijn vrije tijd met tuinieren, wandelen, dansen en mijn kippen, katten en hond.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/erna-van-dijk.jpg",
            Email = "erna@vandijkmedischadvies.nl",
            PhoneNumber = "+31612300695",
            Club = "Scherpenzeel- Woudenberg",
            District = "1570",
            Functions = new List<string> { "DJC 1570" }
        });

        mdjc.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Mario Meeuwse",
            Bio = @"Mijn naam is Mario Meeuwse en ik ben District Jeugd Commissaris van District 1580.
Gedurende mijn Rotaract lidmaatschap en later Rotary heb ik veel uitwisselingen meegemaakt.
Daarnaast was ik actief in voor de Rotary Youth Leadership Award commissie in District 1610.
Ook heb ik veel internationale activiteiten bijgewoond zoals (wereld)congressen en (district)conferenties.
Zelf heb ik een Group Study Exchange gedaan naar Japan, waar ik met veel dankbaarheid en plezier op terugkijk. Een geweldige ervaring naar een land met een heel andere cultuur met enthousiaste mensen binnen de Rotary familie.
Daarom wil ik ook een steentje bijdragen aan uitwisselingen en de jeugd een onvergetelijke ervaring bezorgen.

Ik woon in Aalsmeer met Jikkemine en onze twee zonen.
Wij hebben elkaar leren kennen toen wij Rotaracters waren op weg naar Santiago de Compostella tijdens het 100 jarige bestaan van Rotary.

In het dagelijks leven ben ik accountmanager Grootzakelijk bij de Rabobank, gespecialiseerd in ICT & Zorg.
Mijn hobby's zijn: reizen, talen, skiën, zeilen & zwemmen.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/mario-meeuwse.jpg",
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Club = "RC Haarlemmermeer",
            District = "1580",
            Functions = new List<string> { "DJC 1580" }
        });

        mdjc.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Judith Siebring",
            Bio = @"Mijn naam is Judith Siebring, outbound Coördinator longterm RYE voor de regio's Midden- en Zuid-Amerika.

Op mijn 16e (lang geleden… ;-)) ben ik een jaar naar London, Ontario, Canada geweest op uitwisseling via de Rotary. Ik heb een fantastisch jaar gehad waar ik nog ontzettend vaak aan terugdenk. Het heeft ook veel impact gehad op latere keuzes en ervaringen in mijn leven. Reizen, andere mensen, talen en culturen leren kennen; het zit in mijn bloed. Zo heb ik tijdens mijn studie ook nog een jaar in Uruguay in Zuid-Amerika gestudeerd, en heb ik later nog in Canada en Nieuw-Zeeland gewoond en gewerkt. Inmiddels woon ik alweer een aantal jaar in Emmen en ben daar lid geworden van Rotaryclub Emmen-'t Loo. Ik ben blij dat ik nu mijn steentje kan bijdragen aan het RYE-programma als jeugdcommissaris in mijn club, gastouder én als outbound Coördinator voor de regio's Midden- en Zuid-Amerika. Ik kijk er naar uit om jongeren een stapje op weg te helpen naar en tijdens het jaar van hun leven, met al z'n ups en downs. Daarnaast ben ik blij dat ik de kans krijg om mijn Spaans een beetje te oefenen en contacten te onderhouden met mijn 'Rotary collega's' in het prachtige Zuid-Amerika.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/judith-siebring.jpg",
            Email = string.Empty,
            PhoneNumber = "+31652682275",
            Club = "RC Emmen-'t Loo",
            District = "1590 NOORD-NEDERLAND",
            Functions = new List<string> { "DJC 1590" }
        });

        mdjc.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Elzeline Fischer",
            Bio = @"Sinds November 2022 ben ik de District Jeugd Commissaris van D1600 (DJC). Ik ben in 1974 in Leeuwarden geboren. Mijn vader is Rotarian bij RC Leeuwarden-Zuid. In 1992-1993 ben ik via Rotary uitgezonden naar Boyne City, Michigan in District 6290. Dit is een land-overschrijdend district! Michigan USA en Ontario Canada liggen hier o.a. in. Ik ben getrouwd met Pierre en samen hebben we twee kinderen. Sinds 2021 ben ik lid van Rotary. Dat lidmaatschap ben ik vooral aangegaan omdat ik het Jeugdprogramma van Rotary onovertroffen vind. We bieden veel aan voor een grote groep jonge mensen. En deze groep nieuwe kansen bieden en zich helpen ontwikkelen in hun zelfbeeld en wereldbeeld is volgens mij het begin van een mooiere wereld voor iedereen.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/elzeline-fischer.png",
            Email = "djc@rotary-d1600.nl",
            PhoneNumber = string.Empty,
            Club = "RC Voorburg",
            District = "1600",
            Functions = new List<string> { "DJC 1600" }
        });

        var longterm = new ContactSection { Id = "longterm", Title = "Long Term" };

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Marga Oosterveld",
            Bio = @"Hallo, ik ben een oud uitwisselingsstudent of exchangee zoals dat heet. In het jaar 1988 - 1989 ben ik met Rotary een jaar naar het buitenland geweest. ""Class of 89"" noemen ze dat in Amerika. Eigenlijk wilde ik graag naar het noordoosten, maar ik kwam terecht in het zuidwesten van de USA. Totaal anders dan Nederland met indianen en cowboys, midden in de woestijn en in de bergen. Het is niet altijd makkelijk en soms best wel even slikken, maar als je dat lukt, heb je de tijd van je leven. Nu ben ik contactpersoon tussen de districten in de USA, Canada en Zuid Afrika om Rotary Clubs te vinden die willen uitwisselen met Nederland voor a lifetime in a year !!",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/marga-oosterveld.jpg",
            Email = "longtermout@rotaryyep.nl",
            PhoneNumber = "+31629586813",
            Club = "Rotary Club Oosterwolde",
            District = "1590 NOORD-NEDERLAND",
            Functions = new List<string> { "Chair Longterm", "Coördinator Amerika, Canada, Azië en Europa" }
        });

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Sandra Cools-Wemer",
            Bio = string.Empty,
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/sandra-cools-wemer.jpeg",
            Email = "longtermin@rotaryyep.nl",
            PhoneNumber = string.Empty,
            Club = string.Empty,
            District = string.Empty,
            Functions = new List<string> { "Inbound coördinator" }
        });

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Jitte Wigbold",
            Bio = string.Empty,
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/jitte-wigbold.jpg",
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Club = string.Empty,
            District = string.Empty,
            Functions = new List<string> { "Inbound coördinator" }
        });

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Jet Bebseler",
            Bio = string.Empty,
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/jet-bebseler.jpg",
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Club = string.Empty,
            District = string.Empty,
            Functions = new List<string> { "Inbound coördinator" }
        });

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Judith Siebring",
            Bio = @"Mijn naam is Judith Siebring, outbound Coördinator longterm RYE voor de regio's Midden- en Zuid-Amerika. 

Op mijn 16e (lang geleden… ;-)) ben ik een jaar naar London, Ontario, Canada geweest op uitwisseling via de Rotary. Ik heb een fantastisch jaar gehad waar ik nog ontzettend vaak aan terugdenk. Het heeft ook veel impact gehad op latere keuzes en ervaringen in mijn leven. Reizen, andere mensen, talen en culturen leren kennen; het zit in mijn bloed. Zo heb ik tijdens mijn studie ook nog een jaar in Uruguay in Zuid-Amerika gestudeerd, en heb ik later nog in Canada en Nieuw-Zeeland gewoond en gewerkt. Inmiddels woon ik alweer een aantal jaar in Emmen en ben daar lid geworden van Rotaryclub Emmen-'t Loo. Ik ben blij dat ik nu mijn steentje kan bijdragen aan het RYE-programma als jeugdcommissaris in mijn club, gastouder én als outbound Coördinator voor de regio's Midden- en Zuid-Amerika. Ik kijk er naar uit om jongeren een stapje op weg te helpen naar en tijdens het jaar van hun leven, met al z'n ups en downs. Daarnaast ben ik blij dat ik de kans krijg om mijn Spaans een beetje te oefenen en contacten te onderhouden met mijn 'Rotary collega's' in het prachtige Zuid-Amerika.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/judith-siebring.jpg",
            Email = "longtermout@rotaryyep.nl",
            PhoneNumber = "+31652682275",
            Club = "RC Emmen-'t Loo",
            District = "1590 NOORD-NEDERLAND",
            Functions = new List<string> { "Coördinator Midden- en Zuid-Amerika, Europa" }
        });

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Ben Mureau",
            Bio = @"Mijn naam is Ben Mureau en ik verzorg sinds enkele jaren de visa voor de inbounds en de verzekeringen voor de in- en outbounds.

In het dagelijkse leven ben ik actief als innovatie directeur bij een multi nationale onderneming, ben getrouwd en heb 3 kinderen.

Ik ben in de organisatie gerold toen mijn dochter ook deelnam aan het long term exchange programma. Het is werkelijk fantastisch om deel uit te mogen maken van het enthousiaste en inspirerende team dat de long term exchange organiseert en begeleidt. Samen met de Rotex'ers (oud deelnemers long term exchange) en het LT team organiseren we verschillende activiteiten en zorgen ook voor de begeleiding van de exchangers, samen met de gastouders natuurlijk.

Als je beseft wat een exchange jaar voor de jongeren betekent, dan kan je alleen maar dankbaar zijn dat je daar een bijdrage aan kan en mag leveren.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/ben-mureau.jpg",
            Email = "longtermadmin@rotaryyep.nl",
            PhoneNumber = "+31651911244",
            Club = "RC Oldenzaal",
            District = "1560 OOST-NEDERLAND",
            Functions = new List<string> { "Administrator Longterm" }
        });

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Betty Rijkmans-Siemens",
            Bio = @"Jarenlang was ik docent voortgezet onderwijs en werkte altijd met veel plezier met middelbare scholieren. Dat doe ik nu als coördinator van de Dutch Orientation Course. Long term exchangestudenten in Nederland hebben in hun uitwisselingsjaar gezamenlijke activiteiten. Een van de eerste activiteiten is de Dutch Orientation Course. Een super gezellige week ergens in Nederland waarin de studenten intensief aan de gang gaan met het leren van de Nederlandse taal en tegelijk ook kennis maken met de Nederlandse cultuur. De week is altijd een groot succes. De studenten leren elkaar beter kennen en naast serieus leren is er voldoende tijd om leuke dingen te doen. Allemaal even gezellig. Het team van docenten, samen met ondersteuning van Rotexers verheugen zich altijd weer op deze kennismaking.

Later in het uitwisselings jaar zien we elkaar nog vaker en monitoren we hoe het gaat met iedereen. Als het jaar voorbij is hebben veel exchangers Nederland in hun hart gesloten en andersom net zo!",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/betty-rijkmans-siemen.jpeg",
            Email = "doc@rotaryyep.nl",
            PhoneNumber = "+31629523379",
            Club = "Rotaryclub Meppel",
            District = "1590 NOORD-NEDERLAND",
            Functions = new List<string> { "Coördinator Dutch Orientations Course (DOC)" }
        });

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Bas Siebring",
            Bio = @"Mijn naam is Bas Siebring. In het dagelijks leven ben ik docent scheikunde. Omdat ik een aantal jaar in Canada en Nieuw-Zeeland gewoond en gewerkt heb, geef ik nu (in Nederland) een deel van mijn lessen in het Engels op een school die tweetalig onderwijs aanbiedt.

Toen een aantal jaar geleden er een kans lag om bij de Dutch Orientation Course mee te helpen als docent, heb ik die kans met beide handen gegrepen. Inbounds helpen de Nederlandse taal onder de knie te krijgen lijkt ook wel een beetje op Nederlandse leerlingen helpen Engels te leren.

Integreren in een ander land in een andere cultuur, ik heb het zelf twee keer mogen doen in zowel Canada als Nieuw-Zeeland. Zo'n ""inburgeringsproces"" gaat gepaard met ups en downs. Mijn doel is om er voor te zorgen dat de DOC voor elke deelnemer één van die ups is; en dat het daarnaast een ervaring is die inbounds voorbereidt en helpt om in de rest van het exchange jaar nog veel meer ups te mogen meemaken.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/bas-siebring.jpeg",
            Email = "doc@rotaryyep.nl",
            PhoneNumber = "+31629523379",
            Club = string.Empty,
            District = string.Empty,
            Functions = new List<string> { "Coördinator Dutch Orientations Course (DOC)" }
        });

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Steven Stolp",
            Bio = @"Als scholier had ik geen flauw benul van het bestaan van uitwisselingen. In mijn studententijd heb ik dat ingehaald door mijn eigen exchanges te organiseren, (korter) werken en later studeren in (zuid) Frankrijk en vervolgens langer naar Ouagadougou in Burkina Faso, West-Afrika. Buiten de Nederlandse context ontwikkel je je net wat anders. Dat gun ik iedereen, en de wereld.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/steven-stolp.png",
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Club = "RC Bennekom",
            District = "1560 OOST-NEDERLAND",
            Functions = new List<string> { "Activities inbounds" }
        });

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Hilleke van der Veer",
            Bio = @"Mijn naam is Hilleke van der Veer en ik ben de landelijke counselor van de inbounds.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/hilleke-van-der-veer-2.jpg",
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Club = string.Empty,
            District = string.Empty,
            Functions = new List<string> { "Landelijk counselor" }
        });

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Christian van Dam",
            Bio = string.Empty,
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/christian-van-dam.jpg",
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Club = string.Empty,
            District = string.Empty,
            Functions = new List<string> { "Landelijk counselor" }
        });

        longterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Ruben Talstra",
            Bio = @"Mijn naam is Ruben Talstra en ik ben de web-app master van de long term exchange. In het dagelijks leven ben ik student aan de Hanze Hogeschool in Groningen, waar ik de opleiding Business IT & Management volg. Ik ben zelf ook op exchange geweest in 2018-2019 naar Halifax in Canada. Dit was een geweldige ervaring waar ik met veel plezier op terugkijk en die ik iedere jongere gun. Daarom vind ik het zo fijn om deel uit te maken van dit geweldige team dat zich met veel enthousiasme inzet om de uitwisselingsstudenten een onvergetelijke ervaring te bezorgen hier in Nederland.",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/ruben-talstra.jpg",
            Email = "RubenTalstra1211@outlook.com",
            PhoneNumber = string.Empty,
            Club = string.Empty,
            District = string.Empty,
            Functions = new List<string> { "Web-app master" }
        });

        var shortterm = new ContactSection { Id = "shortterm", Title = "Short Term" };

        shortterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Jan van Aller",
            Bio = @"Ik ben Jan van Aller, assistent bij het Short Term Exchange Programma.

In 2021 verscheen een landelijke oproep om de gelederen van het RYEX-werk te komen versterken. Ik heb me toen aangemeld. Omdat er door Corona een hoop stil was komen te liggen is er in deze fase weer veel te doen om de lopende programma's opnieuw op te tuigen en uit te voeren, en ik vind het mooi en zinvol om daar samen met de anderen uitvoering aan te geven.

Ik ben sinds 2015 lid van RC Haarlem-Centrum; daarvoor was ik lid van RC Alkmaar. Ik merk dat de betrokkenheid van lokale clubs bij de uitwisselingen sterk kan verschillen. mede daarom vind ik het de moeite waard om vanuit het landelijke level de lokale clubs te ondersteunen, te informeren en zo nodig te enthousiasmeren.

Uit mijn vrienden- en familiekring weet ik van dichtbij, hoe ontzettend waardevol de uitwisselingen zijn. Uiteraard in de eerste plaats voor de deelnemers zelf. Uit hun ervaringen blijkt vaak dat het 'life-changing' periodes zijn geweest die hen enorm hebben geholpen om maatschappelijk betrokken (wereld)burgers te worden. Hoe mooi is dat! – En ook voor deelnemende clubs hebben de uitwisselingen zeker een meerwaarde.

Ik ben werkzaam als geestelijk verzorger bij de Politie; een vrij nieuwe werksoort , die we volop aan het ontwikkelen zijn. Daarvoor ben ik in drie kerken ( P.K.N. ) voorganger geweest: Rotterdam, Uitgeest, Haarlem. En verder ben ik 10 jaar geestelijk verzorger bij de K. Marine geweest. We hebben naast veel plekken in NL ook een aantal jaren op Curaçao gewoond. Dat de wereld groter is dan Nederland hebben onze drie dochters dus intensief ervaren.

Dat is ook mijn drive om me aan te melden voor MDJC: jongen mensen de kans geven om hun steentje bij te dragen aan een wereld waarin er meer begrip is voor de verschillen, waarmee we samen deze aarde een stukje bewoonbaar proberen te maken!",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/short-term/jan-van-aller.jpg",
            Email = "gjvanaller@gmail.com",
            PhoneNumber = "+31630005630",
            Club = "RC Haarlem-Centrum",
            District = "1580 NOORD-HOLLAND",
            Functions = new List<string> { "Coordinator Family to Family" }
        });

        shortterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Marja Hofland",
            Bio = string.Empty,
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/marja-hofland.jpg",
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Club = string.Empty,
            District = string.Empty,
            Functions = new List<string> { "Inbound coördinator Zomerkampen" }
        });

        shortterm.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Betty Rijkmans-Siemens",
            Bio = @"Jarenlang was ik docent voortgezet onderwijs en werkte altijd met veel plezier met middelbare scholieren. Dat doe ik nu als coördinator van de Dutch Orientation Course. Long term exchangestudenten in Nederland hebben in hun uitwisselingsjaar gezamenlijke activiteiten. Een van de eerste activiteiten is de Dutch Orientation Course. Een super gezellige week ergens in Nederland waarin de studenten intensief aan de gang gaan met het leren van de Nederlandse taal en tegelijk ook kennis maken met de Nederlandse cultuur. De week is altijd een groot succes. De studenten leren elkaar beter kennen en naast serieus leren is er voldoende tijd om leuke dingen te doen. Allemaal even gezellig. Het team van docenten, samen met ondersteuning van Rotexers verheugen zich altijd weer op deze kennismaking.

Later in het uitwisselings jaar zien we elkaar nog vaker en monitoren we hoe het gaat met iedereen. Als het jaar voorbij is hebben veel exchangers Nederland in hun hart gesloten en andersom net zo!",
            ImageUrl = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/organization/long-term/betty-rijkmans-siemen.jpeg",
            Email = "doc@rotaryyep.nl",
            PhoneNumber = "+31629523379",
            Club = "Rotaryclub Meppel",
            District = "1590 NOORD-NEDERLAND",
            Functions = new List<string> { "Coördinator Zomerkampen buitenland" }
        });

        var rotex = new ContactSection { Id = "rotex", Title = "ROTEX" };

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Anouk",
            Bio = "Anouk is de voorzitter van ROTEX Nederland. Als voormalig exchange student helpt zij nu andere jongeren bij hun voorbereidingen en begeleiding tijdens hun uitwisseling.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Voorzitter" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Quinten",
            Bio = "Quinten is de secretaris van ROTEX Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Secretaris" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Marre",
            Bio = "Marre is hoofd activiteiten bij ROTEX Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Hoofd Activiteiten" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Sander",
            Bio = "Sander is commissiehoofd inbounds bij ROTEX Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissiehoofd Inbounds" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Emily",
            Bio = "Emily is commissielid inbounds bij ROTEX Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissielid Inbounds" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Britt",
            Bio = "Britt is commissielid inbounds bij ROTEX Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissielid Inbounds" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Madyke",
            Bio = "Madyke is commissielid inbounds bij ROTEX Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissielid Inbounds" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Lysanne",
            Bio = "Lysanne is commissielid inbounds bij ROTEX Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissielid Inbounds" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Merle",
            Bio = "Merle is commissiehoofd extern bij ROTEX Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissiehoofd Extern" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Philipien",
            Bio = "Philipien is commissielid extern bij ROTEX Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissielid Extern" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Marcella",
            Bio = "Marcella is commissielid extern bij ROTEX Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissielid Extern" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Floor",
            Bio = "Floor is commissiehoofd pre-rebounds bij ROTEX Nederland en helpt uitwisselingsstudenten bij hun terugkeer naar Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissiehoofd Pre-Rebounds" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Catheline",
            Bio = "Catheline is commissielid pre-rebounds bij ROTEX Nederland en helpt uitwisselingsstudenten bij hun terugkeer naar Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissielid Pre-Rebounds" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Thil",
            Bio = "Thil is commissielid pre-rebounds bij ROTEX Nederland en helpt uitwisselingsstudenten bij hun terugkeer naar Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissielid Pre-Rebounds" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Bo",
            Bio = "Bo is commissielid pre-rebounds bij ROTEX Nederland en helpt uitwisselingsstudenten bij hun terugkeer naar Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissielid Pre-Rebounds" }
        });

        rotex.Contacts.Add(new RotaryYepNL.Models.Contact
        {
            Name = "Tom",
            Bio = "Tom is commissielid pre-rebounds bij ROTEX Nederland en helpt uitwisselingsstudenten bij hun terugkeer naar Nederland.",
            ImageUrl = string.Empty,
            Email = string.Empty,
            PhoneNumber = string.Empty,
            Functions = new List<string> { "Commissielid Pre-Rebounds" }
        });

        return new List<ContactSection> { mdjc, longterm, shortterm, rotex };
    }
}
