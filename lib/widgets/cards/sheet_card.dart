import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/models/character.dart';
import 'package:brunohsp_app/pages/character/character_update.dart';
import 'package:brunohsp_app/widgets/cards/default_card.dart';
import 'package:brunohsp_app/widgets/utils/section.dart';
import 'package:brunohsp_app/widgets/utils/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SheetCard extends DefaultCard {
  final Character character;

  SheetCard(
      {required columns,
      required BuildContext context,
      required this.character,
      Key? key})
      : super(
            key: key,
            columns: columns,
            child: _SheetCardChildren(
              character: character,
              context: context,
            ));
}

class _SheetCardChildren extends StatelessWidget {
  final Character character;
  final BuildContext context;

  const _SheetCardChildren(
      {required this.character, required this.context, Key? key})
      : super(key: key);

  topHeaderBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: CircleAvatar(radius: 24),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 0,
                child: Text(
                  character.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    character.dndClass.name,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text('nvl. ${character.level}'),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  bottomHeaderBuilder() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Tag(
              badge: const Icon(
                Icons.favorite_rounded,
                size: 18,
              ),
              label: character.hp.toString()),
          Tag(
              badge: const Icon(
                Icons.shield_rounded,
                size: 18,
              ),
              label: character.armor.toString()),
          Tag(
            badge: const Icon(
              Icons.star_rounded,
              size: 18,
            ),
            label: character.proficiency.toString(),
          )
        ],
      ),
    );
  }

  headerBuilder() {
    return Column(
      children: [
        topHeaderBuilder(),
        bottomHeaderBuilder(),
        const Divider(),
      ],
    );
  }

  resistanceBuilder() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Section(
                title: 'Resistência',
                weight: FontWeight.normal,
                size: 18,
                titlePadding: 8,
                noMargin: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Tag(
                            badge: SvgPicture.asset(
                              'assets/icons/resistanceIcons/strength.svg',
                              width: 24,
                              height: 24,
                            ),
                            label: character.resistances.strength.toString()),
                        Tag(
                            badge: SvgPicture.asset(
                              'assets/icons/resistanceIcons/intelligency.svg',
                              width: 24,
                              height: 24,
                            ),
                            label:
                                character.resistances.inteligency.toString()),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tag(
                            badge: SvgPicture.asset(
                              'assets/icons/resistanceIcons/dexterity.svg',
                              width: 24,
                              height: 24,
                            ),
                            label: character.resistances.dexterity.toString()),
                        Tag(
                            badge: SvgPicture.asset(
                              'assets/icons/resistanceIcons/wisdom.svg',
                              width: 24,
                              height: 24,
                            ),
                            label: character.resistances.wisdom.toString()),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Tag(
                            badge: SvgPicture.asset(
                              'assets/icons/resistanceIcons/constitution.svg',
                              width: 24,
                              height: 24,
                            ),
                            label:
                                character.resistances.constitution.toString()),
                        Tag(
                            badge: SvgPicture.asset(
                              'assets/icons/resistanceIcons/charism.svg',
                              width: 24,
                              height: 24,
                            ),
                            label: character.resistances.charism.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  skillBuilder() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Section(
                title: 'Perícias',
                weight: FontWeight.normal,
                size: 18,
                titlePadding: 8,
                noMargin: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/acrobatics.svg'),
                          label: character.skills.acrobatics.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/arcana.svg'),
                          label: character.skills.arcana.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/athletics.svg'),
                          label: character.skills.athletics.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/performance.svg'),
                          label: character.skills.performance.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/deception.svg'),
                          label: character.skills.deception.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/stealth.svg'),
                          label: character.skills.stealth.toString(),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/history.svg'),
                          label: character.skills.history.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/intimidation.svg'),
                          label: character.skills.intimidation.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/insight.svg'),
                          label: character.skills.insight.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/investigation.svg'),
                          label: character.skills.investigation.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/animal_handling.svg'),
                          label: character.skills.animalHandling.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/medicine.svg'),
                          label: character.skills.medicine.toString(),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/nature.svg'),
                          label: character.skills.nature.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/perception.svg'),
                          label: character.skills.perception.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/persuation.svg'),
                          label: character.skills.persuation.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/sleight_of_hand.svg'),
                          label: character.skills.sleightOfHand.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/religion.svg'),
                          label: character.skills.religion.toString(),
                        ),
                        Tag(
                          badge: SvgPicture.asset(
                              'assets/icons/skillIcons/survival.svg'),
                          label: character.skills.survival.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CharacterUpdate(
                      character: character,
                    ),
                  ),
                );
              },
              child: const Text('Atualizar'),
            ),
            OutlinedButton(
              onPressed: () {
                confirmationModal();
              },
              child: const Text('Remover'),
            ),
          ],
        ),
      ],
    );
  }

  confirmationModal() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Você tem certeza que deseja remover essa ficha?',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                Row(
                  children: [
                    SizedBox(
                      width: Calculate.widthWithColumns(
                          2, MediaQuery.of(context).size.width),
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Sim'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: Calculate.widthWithColumns(
                          2, MediaQuery.of(context).size.width),
                      child: OutlinedButton(
                        child: const Text('Não'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        headerBuilder(),
        resistanceBuilder(),
        skillBuilder(),
      ],
    );
  }
}
