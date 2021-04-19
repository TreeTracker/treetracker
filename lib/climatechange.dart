import 'package:flutter/material.dart';

void main() {
  runApp(ClimateChange());
}

class ClimateChange extends StatefulWidget {
  ClimateChange({Key key}) : super(key: key);

  @override
  _ClimateChangeState createState() => _ClimateChangeState();
}

class _ClimateChangeState extends State<ClimateChange> {
  var title1 = 'HOW DO WE KNOW THAT THE EARTH IS WARMING?';
  var text1 =
      'Independent temperature records from multiple official sources confirm that there is absolutely absolutely no doubt whatsoever that the Earth is warming. Indeed, each of the last three decades has been successively warmer than the one before, 19 of the top 20 warmest years have occurred in the last 19 years, and the past four years have been the hottest on record.  2016 was the hottest year ever recorded, whilst in 2019, nearly 400 temperature records were broken across 29 countries, June 2019 was the hottest on record, and July 2019 was the hottest month ever recorded. As of July 2020, January 2020 was the warmest January ever recorded in Europe, we saw the hottest May ever and we already have an 85% chance that 2020 will turn out to be the hottest year on record.';
  var title2 = 'HASN’T IT BEEN HOTTER THAN THIS IN THE PAST?';
  var text2 =
      'The planet is now very probably hotter than at any point in at least the last 125,000 years, long before human civilisation began, when sea levels reached over 6 m higher than they are today. But what’s even more concerning is how fast our temperatures are rising. Over the past 45 years, our planet’s temperature has been increasing a whopping 170 times faster than the baseline rate of cooling over the previous 7,000 years. Indeed, our current rate of warming is unprecedented over the last 10,000 years. Over the rest of this century, future temperature rises are predicted to be taking place not just much faster than it did during our recovery from the last ice age but hundreds of times faster than any extended period of warming in the last 65 million years. That’s when the dinosaurs went extinct. Crucially, when temperatures rise this fast, it is impossible for many living creatures and plants to have time to adapt to such changes. Not to mention the fact that many places on Earth that creatures would have previously used to take refuge from increasing temperatures have now been degraded, fragmented or colonised by human activities. The bottom line is that the changes in temperatures that we’ve been seeing on our planet in recent years are truly unprecedented.';
  var title3 = 'WHY IS THE EARTH GETTING WARMER?';
  var text3 =
      'The temperature at the Earth’s surface is controlled primarily by the levels of certain gases in the atmosphere, such as water vapour, carbon dioxide and methane. Although these gases only make up a tiny fraction of our atmosphere (current carbon dioxide levels are around 410 parts per million (ppm), which is just 0.041%), just like how a drop of ink can affect the colour of a huge volume of water, tiny amounts of these gases can have enormous impacts on our atmosphere. Due to their special structure, these molecules can absorb heat emitted from the Earth’s surface as a result of it having been warmed by the Sun, preventing some of that heat from escaping back out into Space. In this way, it can be said that the gases provide an insulating ‘blanket’ around the Earth, which traps heat in our atmosphere keeping us warm.';
  var title4 = 'WHAT IS THE GREENHOUSE EFFECT?';
  var text4 =
      'This heating effect has ( somewhat wrongly) been compared to how the glass roof of a greenhouse traps heat energy from the Sun, keeping the inside of the greenhouse warmer than its surroundings. Hence this phenomenon has become known as the greenhouse effect and the gases known as greenhouse gases. We have known about the greenhouse effect for well over 150 years, and the science behind it is well established. The greenhouse effect, in its natural form, is essential for life here on Earth; without greenhouse gases in our atmosphere, the average temperature at the Earth’s surface would be around -18°C, dropping to temperatures at night that would be far too cold for us to survive. However, by burning fossil fuels (as well as by farming cattle, growing rice, burning trees, intensively ploughing soil and using chemical fertilisers) humans have been adding huge quantities of additional greenhouse gases into the atmosphere, ‘supercharging’ the greenhouse effect beyond anything that humans have ever experienced.';
  var title5 = 'DOESN’T THE EARTH’S CLIMATE CHANGE NATURALLY?';
  var text5 =
      'Analysis of air bubbles trapped in Antarctic ice sheets reveals that over the past 800,000 years there also have been periods in the Earth’s history where the carbon dioxide levels have naturally risen and fallen, however this has taken place extremely gradually. These changes are brought about by natural variations in the way in which the Earth travels around the Sun (known as Milankovitch cycles), which lead to changes in the absorption of sunlight on Earth. For example, a small increase in the amount of sunlight being absorbed causes the oceans to warm slightly, which results in some of the carbon dioxide dissolved within them being released back into the atmosphere. The increase in atmospheric carbon dioxide leads to more ocean warming, which causes more carbon dioxide to be released, which causes more warming… and so on and so forth. The changes in temperature caused by this feedback loop, and others like it, drive the transitions into ice ages and back out of them. The last time this happened was around 17,000 years ago, when we began to transition out of our most recent ice age. The key point here is that these natural changes in carbon dioxide levels, triggered by cycles in the Earth’s orbit and modulated by feedback cycles, take place over tens of thousands of years. In contrast, the extremely rapid increases in carbon dioxide levels that we have been seeing over the past 60 years, due to human actions, have been taking place about 100 times faster than any of these previous natural increases. ';
  var title6 = 'IS THE RISE IN CARBON DIOXIDE LEVELS DUE TO HUMAN ACTIVITY?';
  var text6 =
      'Since the Industrial Revolution, humans have been pumping enormous additional quantities of carbon dioxide into the atmosphere due to the burning of fossil fuels: coal, oil and natural gas. Fossil fuels are naturally occurring substances that were formed millions of years ago from the remains of dead plants and sea-creatures. When these fuels are burnt, the carbon compounds that have remained trapped underground for millions of years are converted into carbon dioxide and released, adding extra carbon dioxide into the atmosphere that would not naturally be there. In addition, deforestation on massive scales to clear land for agriculture and livestock has released huge amounts of carbon dioxide back into the atmosphere, and has also meant that there are increasingly fewer trees to absorb excess carbon dioxide from the air. At the same time as humans have been burning fossil fuels and clearing forests, they have also been churning up our planet’s soils through intensive farming practices. Healthy soils hold around 70% of the planet’s land-based organic carbon. However, when soil is repeatedly ploughed or compacted by heavy machinery or livestock, its ability to store carbon is compromised and vast quantities are released back into the atmosphere in the form of carbon dioxide. It’s not just carbon dioxide levels that are increasing due to human actions. Methane levels have more than doubled in the last 150 years. Leaks from the oil and gas industry contribute heavily to the amount of methane in our atmosphere, but the waste sector and agriculture are also major sources. There has also been a huge increase in the number of rice-producing paddy fields and in the breeding of cattle for the meat and dairy industries. Microbes in the waterlogged soils of flooded rice fields release large quantities of methane, as do cows and sheep when they burp and fart due to the presence of similar kinds of microbes in their stomachs that help them to digest grass. In addition, fertilisers and animal waste produce large quantities of nitrous oxide, increasing its levels by around a third in the past 150 years. As our greenhouse gas emissions have risen, so too have global temperatures.';

  var title7 = 'CAN WE BE SURE THAT HUMAN ACTIVITY IS CAUSING GLOBAL HEATING?';
  var text7 =
      'Yes, we can. \n There is now absolutely no doubt that the recent increase in global temperatures is almost entirely due to human factors. A vast body of peer-reviewed scientific evidence confirms that natural cycles, volcanic activity, galactic cosmic rays and changes in solar activity from sunspots have had a negligible effect on our current temperature rise. Instead, rises in global temperature have followed the trajectory of increased greenhouse gas levels. Indeed, scientists have been able to find an unmistakable “ human fingerprint” on climate change. Firstly, the Earth’s atmosphere is reacting exactly as we would expect it to if it were being exposed to an increase in greenhouse gases (as opposed to, for example, if it were experiencing increased solar activity). Secondly, detailed analysis of the carbon atoms in the carbon dioxide accumulating in the atmosphere shows that they must have been released by the burning of fossil fuels. Thirdly, measurements taken by satellites show that increases in greenhouse gases are trapping infra-red radiation from the Earth and causing the atmosphere to heat up. Whilst climate change deniers sometimes post articles or comments from scientists that seem to refute the overwhelming evidence of human-caused global heating, these articles often rely on inaccurate claims about climate science. The scientists themselves tend not to have expertise in a climate-related field, or they have links to the fossil fuels industry – or both. The scientific community as a whole are overwhelmingly concerned about what is going on on our planet. In the words of Professor Lonnie Thompson, director of the Byrd Polar Research Centre: “Virtually all of us are now convinced that global warming poses a clear and present danger to civilization.” Or as the Intergovernmental Panel on Climate Change said in their last assessment report: “Evidence for man-made warming of our climate system is unequivocal.';

  var title8 = 'ARE WE REALLY ENTERING THE SIXTH MASS EXTINCTION?';
  var text8 =
      'It’s not just how many species we are losing; it’s how fast we are losing them. Globally, species are going extinct at rates 100-1,000 times faster than the ‘background rates’ typical of Earth’s past. The 400 vertebrate species that went extinct in the last century should have taken about 800 to 10,000 years to disappear naturally. Amphibians are now disappearing at a rate between 1,000 to 45,000 thousand times faster than natural background rates. Several studies have suggested that things are so bad that we are now entering the Earth’s Sixth Mass Extinction event. Mass extinctions are defined as times when the Earth loses more than three-quarters of its species in a geologically short interval, as has happened only five times in the past 540 million years. ';

  var title9 = 'How can I help?';
  var text9 =
      'The most important way to help this Unsurmountable crisis we face as a species is to TALK ABOUT IT!!!!! Why do you think we are stuck here anyways, Our governments make fake promises, don’t fulfill their part and next year the cycle repeats.It must feel suffocating but let me completely dispel your argument about you just doing your part and making it all better, it may help you conscience but the scale of this crisis is bigger than you and me. If someone can solve this, it’s our government. No one else. They are the only ones who have the money, the power and legislation to make it happen. And for them to take it seriously, we have to. Make it an important topic of debate during elections, ask for your right to live frightfree for you, your children and everyone else. People still haven’t taken Climate change seriously and its upto you to make your peers understand this crisis. You can participate in Protests and be part of groups which voice their opinions actively and ask for climate justice. You can use the browser Ecosia as your default search engine, they plant trees every time you search using them. You can Donate to NGOs which work to save the planet relentlessly everyday.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.grey[800],
        title: Text(
          'Climate Change',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[900],
      body: ListView(
        children: [
          Image(
            image: AssetImage(
              'assets/images/climate.jpg',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  title1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 19,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  '\n' + text1 + '\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
          Image(
            image: AssetImage(
              'assets/images/earthheating.jpg',
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  title2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 19,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  '\n' + text2 + '\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
          Image(
            image: AssetImage('assets/images/earthheating2.jpg'),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  title3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 19,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  '\n' + text3 + '\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
          Image(
            image: AssetImage('assets/images/heat.jpg'),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  title4,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 19,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  '\n' + text4 + '\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
          Image(
            image: AssetImage('assets/images/greenhouse.jpg'),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  title5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 19,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  '\n' + text5 + '\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
          Image(
            image: AssetImage('assets/images/greenhouse2.jpg'),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  title6,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 19,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  '\n' + text6 + '\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
          Image(
            image: AssetImage('assets/images/heat2.jpg'),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  title7,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 19,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  '\n' + text7 + '\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
          Image(
            image: AssetImage('assets/images/survive.jpg'),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  title8,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 19,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  '\n' + text8 + '\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
          Image(
            image: AssetImage('assets/images/exe.jpg'),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  title9,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 19,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  '\n' + text9 + '\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
          Image(
            image: AssetImage('assets/images/talk.png'),
          ),
        ],
      ),
    );
  }
}
