#include "my_hightligher.h"

MyHightligher::MyHightligher(QTextDocument *parent)
    : QSyntaxHighlighter(parent)
{
    QString integer_number = R"(([0-9]+[ \t]*)+)";
    QString real_number = R"(([0-9]+[ \t]*)+\.([0-9]+[ \t]*)+)"; // how to name a pattern?

    QString gcode = R"(G[0-9]+(\.[0-9]+)?)";
    QString value_word = R"([XYZIJKxyzijk][0-9]+(\.[0-9]+)?)"; //[ \t]*([0-9]+[ \t]*)+[\.([0-9]+[ \t]*)+]?)";
    QString comment = R"(\([^\(\)]*\))";

    QTextCharFormat integer_format;
    integer_format.setForeground(Qt::darkYellow);

    QTextCharFormat gcode_format;
    gcode_format.setForeground(Qt::darkRed);

    QTextCharFormat comment_format;
    comment_format.setForeground(Qt::darkGreen);

    QTextCharFormat value_format;
    value_format.setForeground(Qt::darkBlue);

    HighlightingRule rule;

    rule.pattern = QRegExp(gcode);
    rule.format = gcode_format;
    highlightingRules.append(rule);

    rule.pattern = QRegExp(comment);
    rule.format = comment_format;
    highlightingRules.append(rule);

//    rule.pattern = QRegExp(integer_number);
//    rule.format = integer_format;
//    highlightingRules.append(rule);

    rule.pattern = QRegExp(value_word);
    rule.format = value_format;
    highlightingRules.append(rule);
}

void MyHightligher::highlightBlock(const QString &text)
{
    foreach (const HighlightingRule &rule, highlightingRules) {
        QRegExp expression(rule.pattern);
        int index = expression.indexIn(text);
        while (index >= 0) {
            int length = expression.matchedLength();
            setFormat(index, length, rule.format);
            index = expression.indexIn(text, index + length);
        }
    }
}
