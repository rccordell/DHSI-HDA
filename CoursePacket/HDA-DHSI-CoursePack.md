# Course Details

Title: Humanities Data Analysis

Location: Digital Humanities Summer Institute, University of Victoria, British Columbia

Dates: 10-14 June 2019

Instructors: 

+ Ryan Cordell (r.cordell@northeastern.edu) 
+ Greg Palermo (palermo.g@husky.neu.edu)

# Course Description

The basic outlines of the course are sketched on the DHSI website:

This course introduces humanities researchers to the R programming language, with a focus on the analysis and visualization of tabular data (e.g. census records, bibliographic catalogs, etc.) using the Tidyverse suite of R packages. Before the course week, students will be asked to read a few touchstone essays wrestling with the peculiar qualities of humanistic data and the transformations of computational analysis. These essays will undergird our work during the week, helping us tie our practical work with R to broader questions about the nature of evidence in the humanities. The bulk of HDA will be devoted to demystifying the basic syntax of R (along with the operations of RStudio) and learning to import data (primarily as data frames); explore data through common but essential transformations; and visualize data using scatterplots, histograms, and related graphs. The course is a condensed version of [this graduate seminar](http://s17hda.ryancordell.org/) which Ryan Cordell teaches at Northeastern University in Boston.

\newpage

# Code of Conduct

Our code of conduct for this course borrows directly from the stellar model outlined by Northeastern's [Feminist Coding Collective](https://digitalfeministcommons.northeastern.edu/) and can be considered as a complement to DHSI's [Statement on Ethics and Inclusion](http://www.dhsi.org/events.php#ethics+inclusion). The Feminist Coding Collective's Code of Conduct and Community Guidelines are well worth consulting in full, but I have copied and lightly adapted those items most pertinent to the work we will do together during this week.

+ **It’s okay not to know**: Assume that no one inherently knows what we’re learning. We all come to this class with different backgrounds and abilities; none of us (including the instructor) will know everything and that is okay! Encourage a space where it’s okay to ask questions.
+ **Be respectful**: Do not use harmful language or stereotypes that target people of all different gender, abilities, races, ages, ethnicities, languages, socioeconomic classes, body types, sexualities, and other aspects of identity.
+ **Online spaces**: Respect each other in both physical and digital spaces.
+ **Collaborative and inclusive interactions**: Avoid speaking over each other. Instead, we want to practice listening to each other and speaking with each other, not at each other.
+ **Use “I” statements**: focusing on your own interpretation of a situation, rather than placing blame or critiquing someone else.
+ **Harassment clause**: The following behaviors are considered harassment and unacceptable in this community (these are borrowed from the [Django Code of Conduct](https://www.djangoproject.com/conduct/)):
    + Violent threats or language directed against another person.
    + Discriminatory jokes and language.
    + Posting sexually explicit or violent material.
    + Posting (or threatening to post) other people’s personally identifying information (“doxing”).
    + Personal insults, especially those using racist or sexist terms.
    + Unwelcome sexual attention.
    + Advocating for, or encouraging, any of the above behavior.
    + Repeated harassment of others. In general, if someone asks you to stop, then stop.

\newpage

# Prerequisites 

 This course presumes no prior knowledge of R or any other programming language. As much as possible, we have tried to build the lessons to presume no technical expertise beyond the installation of applications on your computer. You will be asked to install some software both prior to and during the week of classes. Once it's installed, we will expect you to be willing to experiment and develop new technical skills. Some of the tools we test you may find useful for your research program; some you will not. But we do expect you to try them with enthusiasm and an open mind.

## On "Coding" in the Digital Humanities

In this course, you will think about coding and you will have to do some coding. If you’ve never coded before, this will be frustrating from time to time. In fact, if you’ve done a lot of coding before, it will still be frustrating from time to time!

For at least the past decade, the question of whether humanists should code has been a vexed one in the digital humanities. In this course won’t dwell on these debates, except to say that the answer to “should I learn to code?” is almost always, “what is your research question?” or "what kinds of questions do you want to teach students to answer?" This course will presume that your research or teaching questions involve either the analysis of data—in which case coding may be the only way to realize your specific vision—or building resources other scholars might want to analyze—in which case you should know the kinds of things sophisticated users will want to do with your tools, so you can make them work better. In other words, this course will not argue every humanist needs to learn to code, but it presumes *you*, specifically, might.

We certainly do not expect anyone to come out of this class a full-fledged developer, nor could we teach you how to become one in one week, however intensive the workshop. We’ll be focusing on building skills less in full-fledged “programming” than in “scripting.” That means instructing a computer in every stage of your work flow, and often involves tweaking code written by others rather than starting from scratch. We hope that by doing some scripting, you’ll come to see that debates over learning to code brush over a lot of intermediate stages and flatten a range of skills into a simple binary (pun intended) achievement.

Even scripting will require you to use a programming language rather than a Graphical User Interface (GUI), which may be almost all the programs you’ve used before. Using a language takes more time at first, but has some distinct advantages over working in a GUI:

1. Your work is saved and more visible for inspection.
2. If you discover an error, you can correct it without losing the work done after the error was made.
3. If you want to amend your process (to analyze a hundred books instead of ten, for instance) but perform the same analysis, you can alter the code only slightly.
4. Perhaps most importantly, working in a programming language will help you better understand the step-by-step processes involved in computational analysis, including the computational analyses that underlie GUIs. Doing this work should help you be more aware of how computers think—or, better, how people think with computers. Even if you never touch a line of code after leaving this class, I hope the experience of it will make you a more thoughtful and critical user of all sorts of programs hereafter.

\newpage
 
# Course Software & Data

+ Teaching datasets will be provided for students on the first day of class. Students will also have the opportunity to explore their own data, if they are so inclined, particularly in the final few days of class. 
+ We will use [RStudio](https://www.rstudio.com/) rather than RStudio Cloud in this course, as we had the chance to test all of our scripts yet with the latter, which is relatively new. You should install RStudio on your computer before the first day of class, as we’ll start using it almost immediately on the first day.
+ One of our exercises will require us to use the online dictionary Wordnik's API (application programming interface). Don't worry if that's not a meaningful term yet. The important thing is that you will need to sign up to get a Wordnik API key at <https://developer.wordnik.com/>. If you donate $5 (to a very worthy cause!) you can get the key within a day, but the free requests can take up to 7 days. Please do this ahead of our class so that you will have a key in time! 

## Why R?

This week we will work in the R programming language, developed for statistical computing. This has three main advantages for the sort of work that historians, literary scholars, and other humanists do:

1. R is easy to download and install through the program [RStudio](https://www.rstudio.com/) or, more recently, the cloud-based application [RStudio Cloud](https://rstudio.cloud/). RStudio makes it easy to do scripting and test your results step by step. RStudio also offers a number of features that make it easy to explore data interactively.
2. R has lots of packages we can use for data analysis, such as dplyr, tidyr, and ggplot2. These are not core R libraries, but they are widely used and offer an intellectually coherent approach to data analysis and presentation. That means that even if you don’t use these particular tools in the future, working with them should help you develop a coherent way of thinking about what data is from the computational side, and what you as a humanist might be able to do with it. The ways of thinking you get from this work will serve you will in thinking about relational databases, structured data for archives, and a welter of other sources.
3. R is free: both “free as in beer,” and “free as in speech,” in the mantra of the [Free Software Foundation](http://www.fsf.org/). That means that R–like the rest of the peripheral tools we’ll talk about—won’t suddenly become inaccessible if you lose a university affiliation.
4. It’s a pirate’s favorite programming language (give it a second). Pirates are important historical and literary figures.

\newpage

# HDA Course Schedule:

## Day 1: Monday, June 10
+ Morning 1: DHSI Orientation
+ Morning 2: Introduction to the class; getting started with RStudio
+ Afternoon 1: The grammar of R
+ Afternoon 2: Building a poetry bot

## Day 2: Tuesday, June 11
+ Morning 1: Data frames and tibbles
+ Morning 2: Exercises
+ Afternoon 1: Transforming tabular data 1
+ Afternoon 2: Exercises

## Day 3: Wednesday, June 12
+ Morning 1: Data cleaning
+ Morning 2: Exercises and/or work with student data
+ Afternoon 1: Text Analysis
+ Afternoon 2: Exercises and/or work with student data

## Day 4; Thursday, June 13
+ Morning 1: Topic Modeling
+ Morning 2: Exercises and/or work with student data
+ Afternoon 1: Visualization
+ Afternoon 2: Exercises and/or work with student data

## Day 5: Friday, June 14
+ Morning 1: Exploratory Data Analysis
+ Morning 2: Course wrap up; final questions and certificates

\newpage

# Readings

Below are two lists of readings: a core set of articles we would like you to read, if at all possible, in preparation for our week together. We will devote some class time to discussing these specific texts and some of the larger topics and issues they point us toward. These articles are all provided in PDF form in this coursepack and are organized, roughly, chronologically. 

The second list of penumbral readings is more suggestive: a bibliography for further research after the course, should your interests continue to unfold in these directions. 

## Core Readings:

+ Hadley Wickham, “The Split-Apply-Combine Strategy for Data Analysis” (2011), <https://www.jstatsoft.org/article/view/v040i01>
+ Cecily Carver, “Things I Wish Someone Had Told Me When I Was Learning How to Code” (22 November 2013), <https://medium.freecodecamp.org/things-i-wish-someone-had-told-me-when-i-was-learning-how-to-code-565fc9dcb329> 
+ Catherine D’Ignazio and Lauren F. Klein, “Feminist Data Visualization” (2015) <http://www.kanarinka.com/wp-content/uploads/2015/07/IEEE_Feminist_Data_Visualization.pdf> 
+ Ted Underwood, "Seven Ways Humanists Are Using Computers to Understand Text" (4 June 2015), <https://tedunderwood.com/2015/06/04/seven-ways-humanists-are-using-computers-to-understand-text/>
+ Katie Rawson and Trevor Muñoz, “Against Cleaning” (7 July 2016), <http://curatingmenus.org/articles/against-cleaning/> 
+ Benjamin M. Schmidt, “Do Humanists Need to Understand Algorithms?” *Debates in Digital Humanities 2016*, <http://dhdebates.gc.cuny.edu/debates/text/99>
+ Lincoln Mullen, "Isn't It Obvious?" (10 January 2018), <https://lincolnmullen.com/blog/isnt-it-obvious/>
+ Moacir P. de Sá Pereira, "Representation Matters" (2018), <http://xpmethod.plaintext.in/torn-apart/reflections/moacir_p_de_sa_pereira_2.html>
+ Jo Guldi, “Critical Search: A Procedure for Guided Reading in Large-Scale Textual Corpora,” *Journal of Cultural Analytics (2018), <https://doi.org/10.22148/16.030>

## Penumbral Readings:

The following are organized—not ideally, we acknowledge—in a rough chronological order. We have separated critical articles from textbooks and tutorials, so you can find practical or theoretical help, as you require. 

### Critical Writing

+ Jeannette M. Wing, “Computational Thinking,” Communications of the ACM, 49.3 (Mar. 2006): pg. 33–35
+ Danah Boyd and Kate Crawford, "Critical questions for big data: Provocations for a cultural, technological, and scholarly phenomenon," *Information, Communication & Society* 15.5 (2012): pg. 662-679
+ Ted Underwood, “Topic Modeling Made Just Simple Enough” (7 April 2012), <https://tedunderwood.com/2012/04/07/topic-modeling-made-just-simple-enough/> 
+ The topic modeling issue of the *Journal of Digital Humanities* 2.1 (Winter 2012), <http://journalofdigitalhumanities.org/2-1/>
+ Lisa Gitelman, *”Raw Data” is an Oxymoron*, MIT Press (2013)
+ Lauren F. Klein, “The Image of Absence: Archival Silence, Data Visualization, and James Hemings,” *American Literature* 85.4 (2013)
+ Tanya Clement, “Distant Listening or Playing Visualisations Pleasantly with the Eyes and Ears,” *Digital Studies / Le champ numérique* 3.2 (26 July 2013), <https://www.digitalstudies.org/ojs/index.php/digital_studies/article/view/228> 
+ Brandon T. Locke, “Critical Data Literacy in the Humanities Classroom” (13 August 2013),  <http://brandontlocke.com/2018/08/13/critical-data-literacy-in-the-humanities-classroom.html>
+ Bethany Nowviskie, “Ludic Algorithms,” *Pastplay: Teaching and Learning History with Technology*, University of Michigan Press (2014), <http://quod.lib.umich.edu/d/dh/12544152.0001.001/1:5/--pastplay-teaching-and-learning-history-with-technology?g=dculture;rgn=div1;view=fulltext;xc=1#5.3>
+ Stephen Ramsay, “The Hermeneutics of Screwing Around; or What You Do with a Million Books,” *Pastplay: Teaching and Learning History with Technology*, University of Michigan Press (2014), <http://quod.lib.umich.edu/d/dh/12544152.0001.001/1:5/--pastplay-teaching-and-learning-history-with-technology?g=dculture;rgn=div1;view=fulltext;xc=1#5.1>
+ David Mimno, “Data Carpentry” (2015), <http://www.mimno.org/articles/carpentry/> 
+ Michael A. Gavin, “The Arithmetic of Concepts: a response to Peter de Bolla” (18 September 2015), <http://modelingliteraryhistory.org/2015/09/18/the-arithmetic-of-concepts-a-response-to-peter-de-bolla/>
+ All the essays from *Debates in Digital Humanities 2016*’s [Forum: Text Analysis At Scale](http://dhdebates.gc.cuny.edu/debates/part/14) section, perhaps especially:
    + Stephen Ramsay, “Humane Computation,” <http://dhdebates.gc.cuny.edu/debates/text/94>
    + Tanya E. Clement, “The Ground Truth of DH Text Mining,” <http://dhdebates.gc.cuny.edu/debates/text/96>
    + Lisa Marie Rhody, “Why I Dig: Feminist Approaches to Text Analysis,” <http://dhdebates.gc.cuny.edu/debates/text/97>
    + Joanna Swafford, “Messy Data and Faulty Tools,” <http://dhdebates.gc.cuny.edu/debates/text/100> 
+ Hoyt Long and Richard Jean So, “Literary Pattern Recognition: Modernism between Close Reading and Machine Learning,” *Critical Inquiry* 42.2 (2016)
+ Frederick W. Gibbs, “New Forms of History: Critiquing Data and Its Representations,” *The American Historian* (February 2016), <https://tah.oah.org/february-2016/new-forms-of-history-critiquing-data-and-its-representations/>
+ Ryan Heuser, “Word Vectors in the Eighteenth Century, Episode 1: Concepts” (14 April 2016), <http://ryanheuser.org/word-vectors-1/>, and “Episode 2: Methods” (1 June 2016), <http://ryanheuser.org/word-vectors-2/>
+ Sarah Allison, “Other People’s Data: Humanities Edition,” *CA: the Journal of Cultural Analytics* (8 December 2016), <http://culturalanalytics.org/2016/12/other-peoples-data-humanities-edition/> 
+ Andrew Piper, “Fictionality,” *CA: the Journal of Cultural Analytics* (20 December 2016), <http://culturalanalytics.org/2016/12/fictionality/> 
+ Annette Vee, *Coding Literacy: How Computer Programming Is Changing Writing*, The MIT Press (2017).
+ Andrew Goldstone, “The Doxa of Reading,” *PMLA* 132.3 (2017)
+ Richard Jean So, “All Models Are Wrong,” *PMLA* 132.3 (2017)
+ Johanna Drucker, "Non-representational approaches to modeling interpretation in a graphical environment," *Digital Scholarship in the Humanities* 33.2 (2017): pg. 248-263.
+ Candice Lanius and Gaines S. Hubbell. “The New Data: Argumentation amidst, on, with, and in Data,” *Theorizing Digital Rhetoric*, ed. Aaron Hess and Amber Davisson, 1st edition, Routledge (2017): pg. 126–39.
+ L. Aull, *First-Year University Writing: A Corpus-Based Study with Implications for Pedagogy*, 1st ed., Palgrave Macmillan (2015)
+ Elyse Graham, "Introduction: Data Visualisation and the Humanities," *English Studies* 98.5 (4 July 2017), <https://doi.org/10.1080/0013838X.2017.1332021> 
+ Laura K. Nelson, "Computational Grounded Theory: A Methodological Framework," *Sociological Methods & Research* (21 November 2017), <https://doi.org/10.1177/0049124117729703>
+ Clifford Lynch, “Stewardship in the ‘Age of Algorithms,’” *First Monday* 22.12 (4 December 2017), <http://firstmonday.org/ojs/index.php/fm/article/view/8097> 
+ Katherine Bode, *A World of Fiction: Digital Collections and the Future of Literary History*, Univ. of Michigan Press (2018)
+ Andrew Piper, *Enumerations: Data and Literary Study*, Univ. of Chicago Press (2018)
+ Journal of Writing Analytics, vol 2 (2018) <https://journals.colostate.edu/index.php/analytics/issue/view/13/showToc>
+ Lauren Klein, “Distant Reading After Moretti” (10 January 2018), <http://lklein.com/2018/01/distant-reading-after-moretti/>
+ Ted Underwood, David Bamman, and Sabrina Lee, “The Transformation of Gender in English-Language Fiction,” *CA: the Journal of Cultural Analytics* (13 February 2018), <http://culturalanalytics.org/2018/02/the-transformation-of-gender-in-english-language-fiction/> 
+ Richard Jean So, Hoyt Long, and Yuancheng Zhu, “Race, Writing, and Computation: Racial Difference and the US Novel, 1880-2000,” *CA: Journal of Cultural Analytics* (11 January 2019), <http://culturalanalytics.org/2019/01/race-writing-and-computation-racial-difference-and-the-us-novel-1880-2000/>
+ Ted Underwood, *Distant Horizons: Digital Evidence and Literary Change*, Univ. of Chicago Press (2019)
+ Catherine D’Ignazio and Lauren Klein, *Data Feminism*, MIT Open Press (In Open Review, 2019),  <https://bookbook.pubpub.org/data-feminism>

### Textbooks and Tutorials
 
+ Garrett Grolemund and Hadley Wickham, *R for Data Science* (2017), <https://r4ds.had.co.nz/index.html>
+ Scott Weingart, “Teaching Yourself to Code in DH” (26 February 2017), <http://scottbot.net/teaching-yourself-to-code-in-dh/>
+ Taryn Dewar, "R Basics with Tabular Data," Programming Historian (5 September 2016), <https://programminghistorian.org/en/lessons/r-basics-with-tabular-data>
+ Taylor Arnold and Lauren Tilton, “Basic Text Processing in R,” Programming Historian (27 March 2017), <https://programminghistorian.org/en/lessons/basic-text-processing-in-r> 
+ Nabeel Siddiqui, “Data Wrangling and Management in R,” Programming Historian (31 July 2017), <https://programminghistorian.org/en/lessons/data_wrangling_and_management_in_R>
+ Ryan Deschamps, "Correspondence Analysis for Historical Research with R," Programming Historian (13 September 2017), <https://programminghistorian.org/en/lessons/correspondence-analysis-in-R>
+ Jeff Blackadar, “Introduction to MySQL with R,” Programming Historian (3 May 2018), <https://programminghistorian.org/en/lessons/getting-started-with-mysql-using-r>
+ Alex Brey, “Temporal Network Analysis with R,” Programming Historian, (4 November 2018), <https://programminghistorian.org/en/lessons/temporal-network-analysis-with-r>