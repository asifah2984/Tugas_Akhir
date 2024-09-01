import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_question.dart';
import 'package:flutter/material.dart';

class TajwidQuestionItem extends StatefulWidget {
  const TajwidQuestionItem({
    required this.index,
    required this.question,
    required this.isAdmin,
    this.onChangedCallback,
    this.onEdit,
    this.onDelete,
    super.key,
  })  : isResult = false,
        userResponse = null;

  const TajwidQuestionItem.result({
    required this.index,
    required this.question,
    required this.isAdmin,
    required this.userResponse,
    this.onChangedCallback,
    this.onEdit,
    this.onDelete,
    super.key,
  }) : isResult = true;

  final int index;
  final TajwidQuestion question;
  final bool isAdmin;
  final void Function(String? value)? onChangedCallback;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isResult;
  final String? userResponse;

  @override
  State<TajwidQuestionItem> createState() => _TajwidQuestionItemState();
}

class _TajwidQuestionItemState extends State<TajwidQuestionItem> {
  String? _selectedChoice;

  @override
  void initState() {
    if (widget.isAdmin) {
      _selectedChoice = widget.question.answer;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          width: 28,
          child: Center(
            child: Text(
              '${widget.index + 1}',
              style: Typographies.medium16,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(4),
            child: Ink(
              decoration: BoxDecoration(
                color: Colours.grey50,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colours.grey700.withOpacity(0.45),
                    blurRadius: 2,
                    spreadRadius: 1,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.question.question,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 8),
                  ...widget.question.choices.map((choice) {
                    return RadioListTile<String>(
                      value: choice,
                      groupValue: !widget.isResult
                          ? _selectedChoice
                          : (widget.question.answer == widget.userResponse)
                              ? widget.question.answer
                              : widget.userResponse,
                      onChanged: (value) {
                        if (widget.isAdmin) return;

                        setState(() {
                          _selectedChoice = value;
                        });
                        widget.onChangedCallback?.call(value);
                      },
                      title: Text(choice),
                      tileColor: (widget.isAdmin &&
                                  choice == widget.question.answer) ||
                              (widget.isResult &&
                                  choice == widget.question.answer)
                          ? Colours.success50
                          : widget.isResult && choice == widget.userResponse
                              ? Colours.error50
                              : null,
                      activeColor: !widget.isResult
                          ? Colours.success
                          : (widget.question.answer == widget.userResponse)
                              ? Colours.success
                              : Colours.error,
                      visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    );
                  }),
                  if (widget.isAdmin) const SizedBox(height: 8),
                  if (widget.isAdmin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: widget.onEdit,
                          icon: Icon(
                            Icons.edit_rounded,
                            color: context.colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          style: IconButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: widget.onDelete,
                          icon: Icon(
                            Icons.delete_rounded,
                            color: context.colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
