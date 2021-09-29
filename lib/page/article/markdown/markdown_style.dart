import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:free/utils/developer.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter/cupertino.dart';
import 'package:syntax_highlighter/syntax_highlighter.dart' as sy;
import 'package:url_launcher/url_launcher.dart';

class SubscriptBuilder extends MarkdownElementBuilder {
  static const List<String> _subscripts = ['₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉'];

  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // We don't currently have a way to control the vertical alignment of text spans.
    // See https://github.com/flutter/flutter/issues/10906#issuecomment-385723664
    String textContent = element.textContent;
    String text = '';
    for (int i = 0; i < textContent.length; i++) {
      text += _subscripts[int.parse(textContent[i])];
    }
    return SelectableText.rich(TextSpan(text: text));
  }
}

class SubscriptSyntax extends md.InlineSyntax {
  static final _pattern = r'_([0-9]+)';

  SubscriptSyntax() : super(_pattern);

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    parser.addNode(md.Element.text('sub', match[1]!));
    return true;
  }
}

class CenteredHeaderBuilder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text.text, style: preferredStyle),
      ],
    );
  }
}

class H1HeaderBuilder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return Text(text.text, style: preferredStyle);
  }
}

class HeaderBuilder extends MarkdownElementBuilder {
  HeaderBuilder({required this.padding});

  final double padding;

  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Text(text.text, style: preferredStyle),
    );
  }
}

class HighLight extends SyntaxHighlighter {
  HighLight(this.light);

  bool light;

  @override
  TextSpan format(String source) {
    final sy.SyntaxHighlighterStyle style = light ? sy.SyntaxHighlighterStyle.lightThemeStyle() : sy.SyntaxHighlighterStyle.darkThemeStyle();
    return TextSpan(
        style: const TextStyle(
          fontSize: 12.5,
          height: 1.2,
          fontFamily: 'monospace',
        ),
        children: [sy.DartSyntaxHighlighter(style).format(source)]);
  }
}
