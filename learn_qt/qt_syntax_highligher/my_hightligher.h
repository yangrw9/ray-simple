#ifndef MY_HIGHTLIGHER_H
#define MY_HIGHTLIGHER_H

#include <QSyntaxHighlighter>

// Referencing Qt Syntax Highlighter Example

class MyHightligher : public QSyntaxHighlighter
{
    Q_OBJECT
public:
    explicit MyHightligher(QTextDocument *parent = 0);

protected:
    void highlightBlock(const QString &text);

private:
    struct HighlightingRule
    {
        QRegExp pattern;
        QTextCharFormat format;
    };
    QVector<HighlightingRule> highlightingRules;

signals:

public slots:

};

#endif // MY_HIGHTLIGHER_H
