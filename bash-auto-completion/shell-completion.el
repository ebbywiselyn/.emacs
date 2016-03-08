<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: shell-completion.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="https://www.emacswiki.org/emacs?action=edit;id=shell-completion.el" /><link type="text/css" rel="stylesheet" href="/light.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="https://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: shell-completion.el" href="https://www.emacswiki.org/emacs?action=rss;rcidonly=shell-completion.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="https://www.emacswiki.org/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="https://www.emacswiki.org/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="https://www.emacswiki.org/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for shell-completion.el only"
      href="https://www.emacswiki.org/emacs?action=rss;rcidonly=shell-completion.el" /><meta content="width=device-width" name="viewport" />
<script type="text/javascript" src="/outliner.0.5.0.62-toc.js"></script>
<script type="text/javascript">

  function addOnloadEvent(fnc) {
    if ( typeof window.addEventListener != "undefined" )
      window.addEventListener( "load", fnc, false );
    else if ( typeof window.attachEvent != "undefined" ) {
      window.attachEvent( "onload", fnc );
    }
    else {
      if ( window.onload != null ) {
	var oldOnload = window.onload;
	window.onload = function ( e ) {
	  oldOnload( e );
	  window[fnc]();
	};
      }
      else
	window.onload = fnc;
    }
  }

  // https://stackoverflow.com/questions/280634/endswith-in-javascript
  if (typeof String.prototype.endsWith !== 'function') {
    String.prototype.endsWith = function(suffix) {
      return this.indexOf(suffix, this.length - suffix.length) !== -1;
    };
  }

  var initToc=function() {

    var outline = HTML5Outline(document.body);
    if (outline.sections.length == 1) {
      outline.sections = outline.sections[0].sections;
    }

    if (outline.sections.length > 1
	|| outline.sections.length == 1
           && outline.sections[0].sections.length > 0) {

      var toc = document.getElementById('toc');

      if (!toc) {
	var divs = document.getElementsByTagName('div');
	for (var i = 0; i < divs.length; i++) {
	  if (divs[i].getAttribute('class') == 'toc') {
	    toc = divs[i];
	    break;
	  }
	}
      }

      if (!toc) {
	var h2 = document.getElementsByTagName('h2')[0];
	if (h2) {
	  toc = document.createElement('div');
	  toc.setAttribute('class', 'toc');
	  h2.parentNode.insertBefore(toc, h2);
	}
      }

      if (toc) {
        var html = outline.asHTML(true);
        toc.innerHTML = html;

	items = toc.getElementsByTagName('a');
	for (var i = 0; i < items.length; i++) {
	  while (items[i].textContent.endsWith('✎')) {
            var text = items[i].childNodes[0].nodeValue;
	    items[i].childNodes[0].nodeValue = text.substring(0, text.length - 1);
	  }
	}
      }
    }
  }

  addOnloadEvent(initToc);
  </script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head><body class="default"><div class="header"><a href="https://www.emacswiki.org/emacs/SiteMap" class="logo"><img src="/emacs_logo.png" class="logo" alt="[Home]" /></a><div class="menu"><span class="gotobar bar"><a href="https://www.emacswiki.org/emacs/SiteMap" class="local">SiteMap</a> <a class="local" href="https://www.emacswiki.org/emacs/Search">Search</a> <a href="https://www.emacswiki.org/emacs/ElispArea" class="local">ElispArea</a> <a class="local" href="https://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="https://www.emacswiki.org/emacs/Glossary">Glossary</a> <a class="local" href="https://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a href="https://www.emacswiki.org/emacs/News" class="local">News</a> <a class="local" href="https://www.emacswiki.org/emacs/Problems">Problems</a> <a href="https://www.emacswiki.org/emacs/Suggestions" class="local">Suggestions</a> </span><form method="get" action="https://www.emacswiki.org/emacs" enctype="multipart/form-data" class="search" accept-charset="utf-8"><p><label for="search">Search:</label> <input type="text" name="search"  size="20" id="search" accesskey="f" /> <label for="searchlang">Language:</label> <input type="text" name="lang"  size="10" id="searchlang" /> <input type="submit" name="dosearch" value="Go!" /></p></form></div><h1><a title="Click to search for references to this page" href="https://www.emacswiki.org/emacs?search=%22shell-completion%5c.el%22" rel="nofollow">shell-completion.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="download/shell-completion.el">Download</a></p><pre class="code"><span class="linecomment">;;; shell-completion.el --- provides tab completion for shell commands</span>

<span class="linecomment">;; Copyright (C) 2006 Ye Wenbin</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Author: Ye Wenbin &lt;wenbinye@163.com&gt;</span>
<span class="linecomment">;; Version: $Id: shell-completion.el,v 0.0 2006/08/14 15:08:48 ywb Exp $</span>
<span class="linecomment">;; Package-Version: 0.0</span>
<span class="linecomment">;; Keywords: completion, shell, emacs</span>
<span class="linecomment">;; X-URL: &lt;http://www.emacswiki.org/cgi-bin/wiki/shell-completion.el&gt;</span>

<span class="linecomment">;; This program is free software; you can redistribute it and/or modify</span>
<span class="linecomment">;; it under the terms of the GNU General Public License as published by</span>
<span class="linecomment">;; the Free Software Foundation; either version 2, or (at your option)</span>
<span class="linecomment">;; any later version.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; This program is distributed in the hope that it will be useful,</span>
<span class="linecomment">;; but WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="linecomment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span>
<span class="linecomment">;; GNU General Public License for more details.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; You should have received a copy of the GNU General Public License</span>
<span class="linecomment">;; along with this program; if not, write to the Free Software</span>
<span class="linecomment">;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.</span>

<span class="linecomment">;;; Commentary:</span>

<span class="linecomment">;; Put this file into your load-path and the following into your ~/.emacs:</span>
<span class="linecomment">;; (require 'shell-completion)</span>

<span class="linecomment">;; If you want use with lftp, put this to .emacs</span>
<span class="linecomment">;; (defvar my-lftp-sites (shell-completion-get-file-column "~/.lftp/bookmarks" 0 "[ \t]+"))</span>
<span class="linecomment">;; (add-to-list 'shell-completion-options-alist</span>
<span class="linecomment">;;              '("lftp" my-lftp-sites))</span>
<span class="linecomment">;; (add-to-list 'shell-completion-prog-cmdopt-alist</span>
<span class="linecomment">;;              '("lftp" ("help" "open" "get" "mirror") ("open" my-lftp-sites)))</span>

<span class="linecomment">;;; Code:</span>

(provide 'shell-completion)
(eval-when-compile
  (require 'comint)
  (require 'cl))

(defvar shell-completion-sudo-cmd "<span class="quote">sudo</span>")

(defvar shell-completion-options-alist
  '(
    ("<span class="quote">apt-get</span>" "<span class="quote">remove</span>" "<span class="quote">install</span>" "<span class="quote">update</span>" "<span class="quote">dist-upgrade</span>")
    ("<span class="quote">dpkg</span>" "<span class="quote">--get-selections</span>" "<span class="quote">--set-selections</span>")
    ("<span class="quote">mplayer</span>" "<span class="quote">--help</span>" "<span class="quote">-vobsubid</span>")
    ))

(defvar shell-completion-prog-cmd-alist
  '(
    ("<span class="quote">lftp</span>" "<span class="quote">help</span>" "<span class="quote">open</span>" "<span class="quote">get</span>" "<span class="quote">mirror</span>" "<span class="quote">exit</span>" "<span class="quote">mget</span>")
    ("<span class="quote">mysql</span>" "<span class="quote">show</span>" "<span class="quote">desc</span>" "<span class="quote">create</span>" "<span class="quote">update</span>")
    )
  "<span class="quote">This is alist of command for specific programs.</span>"
  )

(defvar shell-completion-prog-cmdopt-alist
  `(
    ("<span class="quote">mysql</span>" ("<span class="quote">show</span>" "<span class="quote">tables</span>" "<span class="quote">databases</span>") ("<span class="quote">create</span>" "<span class="quote">table</span>" "<span class="quote">database</span>"))
    )
  "<span class="quote">This is alist of options for command in specific programs.</span>")

<span class="linecomment">;;; Completion functions</span>
(defun shell-completion-prog-command ()
  "<span class="quote">Completion for command options in specific program</span>"
  (let ((opt (current-word))
        (prompt (save-excursion
                  (re-search-backward comint-prompt-regexp nil t)
                  (match-string 0)))
        (progs shell-completion-prog-cmd-alist)
        item completions)
    (while (progn                       
             (and progs
                  (null
                   (setq item (car progs)
                         progs (cdr progs)
                         completions (if (string-match (car item) prompt)
                                         (cdr item)))))))
    (let ((success (let ((comint-completion-addsuffix nil))
                     (comint-dynamic-simple-complete opt completions))))
      (if  (and (memq success '(sole shortest)) comint-completion-addsuffix)
          (insert "<span class="quote"> </span>"))
      success)))
  
(defun shell-completion-get-alist ()
  "<span class="quote">When detect we are in some specific programs, use the alist in
`shell-completion-prog-cmdopt-alist'. Otherwise, use `shell-completion-options-alist'.</span>"
  (let ((prompt (save-excursion
                  (re-search-backward comint-prompt-regexp nil t)
                  (match-string 0)))
        (progs shell-completion-prog-cmdopt-alist)
        item alist)
    (while (progn                       
             (and progs
                  (null
                   (setq item (car progs)
                         progs (cdr progs)
                         alist (if (string-match (car item) prompt)
                                   (cdr item)))))))
    (or alist shell-completion-options-alist)))

(eval-after-load "<span class="quote">shell</span>"
  '(progn
(defun shell-completion-cmd-options ()
  "<span class="quote">Completions for command options.

See `shell-completion-options-alist' and `shell-completion-prog-cmdopt-alist'.</span>"
  (let* ((opt (current-word))
         (alist (shell-completion-get-alist))
         (cmd
          (save-excursion
            (shell-backward-command 1)
            (when shell-completion-sudo-cmd
              (if (looking-at (format "<span class="quote">\\s-*%s\\s-+</span>" shell-completion-sudo-cmd))
                  (goto-char (match-end 0))))
            (current-word)))
         (completions (cdr (assoc cmd alist)))
         all item)
    (while completions
      (setq item (car completions)
            completions (cdr completions)
            all (append all
                        (cond ((stringp item) (list item))
                              ((fboundp item) (funcall item))
                              ((boundp item) (symbol-value item))
                              (t (error "<span class="quote">Options for %s is not found!</span>" cmd))))))
    (setq completions all)
    (let ((success (let ((comint-completion-addsuffix nil))
                     (comint-dynamic-simple-complete opt completions))))
      (if (and (memq success '(sole shortest)) comint-completion-addsuffix)
          (insert "<span class="quote"> </span>"))
      success)))
     (add-to-list 'shell-dynamic-complete-functions 'shell-completion-cmd-options t)
     (add-to-list 'shell-dynamic-complete-functions 'shell-completion-prog-command)
     (when shell-completion-sudo-cmd
       (defun shell-backward-command (&optional arg)
         "<span class="quote">Move backward across ARG shell command(s).  Does not cross lines.
See `shell-command-regexp'.</span>"
         (interactive "<span class="quote">p</span>")
         (let ((limit (save-excursion (comint-bol nil) (point))))
           (when (&gt; limit (point))
             (setq limit (line-beginning-position)))
           (skip-syntax-backward "<span class="quote"> </span>" limit)
           (if (re-search-backward
                (format "<span class="quote">[;&|]+[\t ]*\\(%s\\)</span>" shell-command-regexp) limit 'move arg)
               (progn (goto-char (match-beginning 1))
                      (skip-chars-forward "<span class="quote">;&|</span>")))
           (if (looking-at (format "<span class="quote">\\s-*%s\\s-+</span>" shell-completion-sudo-cmd))
               (goto-char (match-end 0))))))))

<span class="linecomment">;;; Some funtions may be useful</span>
<span class="linecomment">;;;###autoload</span>
(defun shell-completion-get-column (start end col &optional sep)
  (let (val)
    (or sep (setq sep "<span class="quote">\t</span>"))
    (save-excursion
      (goto-char start)
      (while (&lt; (point) end)
        (setq val
              (append val
                      (list (nth col (split-string
                             (buffer-substring-no-properties
                              (line-beginning-position)
                              (line-end-position))
                             sep)))))
        (forward-line 1))
      val)))

<span class="linecomment">;;;###autoload</span>
(defun shell-completion-get-file-column (file col &optional sep)
  (with-temp-buffer
    (insert-file-contents file)
    (shell-completion-get-column (point-min) (point-max) col sep)))

<span class="linecomment">;;; shell-completion.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="translation bar"><br />  <a href="https://www.emacswiki.org/emacs?action=translate;id=shell-completion.el;missing=de_en_es_fr_it_ja_ko_pt_ru_se_uk_zh" rel="nofollow" class="translation new">Add Translation</a></span><div class="edit bar"><a accesskey="c" href="https://www.emacswiki.org/emacs/Comments_on_shell-completion.el" class="comment local edit">Talk</a> <a rel="nofollow" class="edit" href="https://www.emacswiki.org/emacs?action=edit;id=shell-completion.el" accesskey="e" title="Click to edit this page">Edit this page</a> <a href="https://www.emacswiki.org/emacs?action=history;id=shell-completion.el" class="history" rel="nofollow">View other revisions</a> <a rel="nofollow" class="admin" href="https://www.emacswiki.org/emacs?action=admin;id=shell-completion.el">Administration</a></div><div class="time">Last edited 2007-10-14 19:27 UTC by ool-18b88310.dyn.optonline.net <a class="diff" rel="nofollow" href="https://www.emacswiki.org/emacs?action=browse;diff=2;id=shell-completion.el">(diff)</a></div><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a class="licence" href="https://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="https://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="https://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="https://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="https://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="https://creativecommons.org/">CreativeCommons</a>
<a href="https://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
<p class="legal" style="padding-top: 0.5em">Please note our <a href="Privacy">Privacy Statement</a>.</p>
</div>
</body>
</html>
