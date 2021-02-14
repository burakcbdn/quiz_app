class Reward {
  int minPoint;
  String title;
  String description;
  String asset;

  Reward({
    this.title,
    this.minPoint,
    this.description,
    this.asset,
  });
}


List<Reward> rewards = [
  Reward(
    minPoint: 25,
    title: "1 Starbucks Kahvesi",
    description: "Tüm starbuckslarda geçerli 10TLye kadar geçerli kahve kuponu: JDM54K",
    asset: "assets/logos/starbucks.png"
  ),  Reward(
    minPoint: 50,
    title: "25 TL Google play kuponu",
    description: "Google playde tüm uygulama ve oyunlarda geçerli 25 TL: MKS746",
    asset: "assets/logos/google_play.png"
  ),  Reward(
    minPoint: 75,
    title: "50 TL Hepsiburada hediye çeki",
    description: "Hepsiburada'da elektronik kategorisinde geçerli 50 TL: TJ56K9",
    asset: "assets/logos/hepsiburada.png"
  ),  Reward(
    minPoint: 100,
    title: "70 TL Trendyol hediye çeki",
    description: "Trendyolda tüm kategorilerde geçerli 70 TL : F987GJ",
    asset: "assets/logos/trendyol.png"
  ),
];
