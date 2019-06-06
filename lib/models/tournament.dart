class Tournament {
  final String id, title, rulesGuidlines;
  final int poolType, pools, prizeStructureType, teamSize;
  final double fee;

//class of PrizeStructure,Pool

  Tournament(this.id, this.title, this.rulesGuidlines, this.poolType,
      this.pools, this.prizeStructureType, this.teamSize, this.fee);
}
