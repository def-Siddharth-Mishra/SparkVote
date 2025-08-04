import 'package:flutter/material.dart';

import '../../domain/models/idea_model.dart';

class IdeaCard extends StatefulWidget {
  final Idea idea;
  final VoidCallback onVote;
  final VoidCallback onShare;

  const IdeaCard({
    Key? key,
    required this.idea,
    required this.onVote,
    required this.onShare,
  }) : super(key: key);

  @override
  _IdeaCardState createState() => _IdeaCardState();
}

class _IdeaCardState extends State<IdeaCard> {
  bool _isExpanded = false;

  Color _getRatingColor(int rating) {
    if (rating >= 90) return Colors.green;
    if (rating >= 80) return Colors.lightGreen;
    if (rating >= 70) return Colors.orange;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.idea.name,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.idea.tagline,
                          style: theme.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: _getRatingColor(widget.idea.rating),
                    child: Text(
                      widget.idea.rating.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: Text(
                  widget.idea.description,
                  maxLines: _isExpanded ? null : 2,
                  overflow: TextOverflow.fade,
                ),
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: widget.idea.hasVoted ? null : widget.onVote,
                    icon: Icon(
                      widget.idea.hasVoted
                          ? Icons.check_circle
                          : Icons.how_to_vote_outlined,
                    ),
                    label: Text('${widget.idea.votes} Votes'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: widget.onShare,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
