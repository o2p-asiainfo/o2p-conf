package com.opensymphony.xwork2.util;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Arrays;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

public class TextUtils
{
  public static final String htmlEncode(String s)
  {
    return htmlEncode(s, true);
  }

  public static final String htmlEncode(String s, boolean encodeSpecialChars)
  {
    s = noNull(s);

    StringBuilder str = new StringBuilder();

    for (int j = 0; j < s.length(); j++) {
      char c = s.charAt(j);

      if (c < '') {
        switch (c) {
        case '"':
          str.append("&quot;");

          break;
        case '&':
          str.append("&amp;");

          break;
        case '<':
          str.append("&lt;");

          break;
        case '>':
          str.append("&gt;");

          break;
        default:
          str.append(c); break;
        }

      }
      else if ((encodeSpecialChars) && (c < 'ÿ')) {
        String hexChars = "0123456789ABCDEF";
        int a = c % '\020';
        int b = (c - a) / 16;
        String hex = "" + hexChars.charAt(b) + hexChars.charAt(a);
        str.append("&#x" + hex + ";");
      }
      else
      {
        str.append(c);
      }
    }

    return str.toString();
  }

  public static final String escapeJavaScript(String s)
  {
    s = noNull(s);
    StringBuffer str = new StringBuffer();

    for (int j = 0; j < s.length(); j++) {
      char c = s.charAt(j);
      switch (c) {
      case '\t':
        str.append("\\t");
        break;
      case '\b':
        str.append("\\b");
        break;
      case '\n':
        str.append("\\n");
        break;
      case '\f':
        str.append("\\f");
        break;
      case '\r':
        str.append("\\r");
        break;
      case '\\':
        str.append("\\\\");
        break;
      case '"':
        str.append("\\\"");
        break;
      case '\'':
        str.append("\\'");
        break;
      case '/':
        str.append("\\/");
        break;
      default:
        str.append(c);
      }
    }
    return str.toString();
  }

  public static final String join(String glue, Iterator<?> pieces)
  {
    StringBuilder s = new StringBuilder();

    while (pieces.hasNext()) {
      s.append(pieces.next().toString());

      if (pieces.hasNext()) {
        s.append(glue);
      }
    }

    return s.toString();
  }

  public static final String join(String glue, String[] pieces)
  {
    return join(glue, Arrays.asList(pieces).iterator());
  }

  public static final String join(String glue, Collection<?> pieces)
  {
    return join(glue, pieces.iterator());
  }

  public static final String noNull(String string, String defaultString)
  {
    return stringSet(string) ? string : defaultString;
  }

  public static final String noNull(String string)
  {
    return noNull(string, "");
  }

  public static final boolean stringSet(String string)
  {
    return (string != null) && (!"".equals(string));
  }

  public static final boolean verifyUrl(String url)
  {
    if (url == null) {
      return false;
    }

    if (url.startsWith("https://"))
    {
      url = "http://" + url.substring(8);
    }
    try
    {
      new URL(url);

      return true; } catch (MalformedURLException e) {
    }
    return false;
  }
}