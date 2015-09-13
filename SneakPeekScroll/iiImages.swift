struct iiImages {
  private static var imageNmaes = [
    "AcanthochoerusGroteiSmit.jpg",
    "AnthusButleriSmit.jpg",
    "BradypterusSylvaticusSmit.jpg",
    "CervicapraThomasinaeSmit.jpg",
    "ChirogaleusMiliiSmit.jpg",
    "Chlorophonia_flavirostris.jpg",
    "DendrohyraxEminiSmit.jpg",
    "HerpestesFerrugineusSmit.jpg",
    "HolacanthusIgnatiusSmit.jpg",
    "Hypothymis_coelestis_coelestis_Smit.jpg"
  ]
  
  static func imageName(var pageIndex: Int) -> String {
    pageIndex = pageIndex % imageNmaes.count
    return imageNmaes[pageIndex]
  }
}