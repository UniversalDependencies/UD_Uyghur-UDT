# Summary

The Uyghur UD treebank is based on the Uyghur Dependency Treebank (UDT),
created at the Xinjiang University in Ürümqi, China.


# Introduction

The sentences come from literature texts / reading material for primary and
middle school, including stories, records and reports.


# Changelog

* 2023-11-15 v2.13
  * Fixed one sentence, regenerated transliteration.
* 2022-11-15 v2.11
  * Fixed validation errors.
* 2021-05-15 v2.8
  * Tense=Aor is undocumented and controversial (see https://github.com/UniversalDependencies/docs/issues/773);
    tentatively replaced with Aspect=Hab|Tense=Pres.
  * Undocumented Cov(erb) is probably better represented as Inf, see https://github.com/UniversalDependencies/docs/issues/747
  * Undocumented nmod:clas changed to compound.
  * Undocumented nmod:abl changed to nmod (the ablative can be recognized by Case=Abl).
  * Adverbially used nominals changed from advmod to obl.
  * Undocumented obj:cau changed to obj (there were only 4 occurrences in test, nowhere else).
  * Undocumented and rare aux:q removed.
  * Converted or removed some other rare and undocumented relation subtypes, such as nmod:ins.
* 2018-04-15 v2.2
  * Repository renamed from UD_Uyghur to UD_Uyghur-UDT.
  * Added new manually checked data (Marhaba Eli); dev cut at 900 sentences, additional 1656 sentences go to train.
  * Added morphological analysis from Apertium (Fran Tyers and Dan Zeman); OOV = 26%.
* 2017-03-01 v2.0
  * Converted to UD v2 guidelines (Dan Zeman).
  * Added new manually checked data (Marhaba Eli).
  * Re-split to achieve 10K test tokens (first 900 sentences); rest is dev, no train now.
* 2016-11-01 v1.4
  * Initial release.



<pre>
=== Machine-readable metadata (DO NOT REMOVE!) ================================
Data available since: UD v1.4
License: CC BY-SA 4.0
Includes text: yes
Genre: fiction
Lemmas: automatic
UPOS: manual native
XPOS: automatic with corrections
Features: automatic
Relations: manual native
Contributors: Eli, Marhaba; Zeman, Daniel; Tyers, Francis
Contributing: elsewhere
Contact: marhaba@xju.edu.cn
===============================================================================
</pre>
