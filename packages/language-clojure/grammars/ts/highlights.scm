;; "Special" things
(list_lit
  "(" @punctuation.section.expression.begin (#is-not? test.descendantOfNodeWithData clojure.dismissTag)
  .
  (sym_lit) @storage.control (#eq? @storage.control "do"))

(list_lit
  "(" @punctuation.section.expression.begin (#is-not? test.descendantOfNodeWithData clojure.dismissTag)
  .
  (sym_lit) @keyword.control.conditional.if (#eq? @keyword.control.conditional.if "if"))

(list_lit
  "(" @punctuation.section.expression.begin (#is-not? test.descendantOfNodeWithData clojure.dismissTag)
  .
  (sym_lit) @keyword.control.conditional.when (#eq? @keyword.control.conditional.when "when"))

(list_lit
  "(" @punctuation.section.expression.begin (#is-not? test.descendantOfNodeWithData clojure.dismissTag)
  .
  (sym_lit) @keyword.control.js.clojure (#eq? @keyword.control.js.clojure "js*"))

;; Syntax quoting
((syn_quoting_lit)
  @meta.syntax-quoted
  (#is? test.ancestorTypeNearerThan "syn_quoting_lit unquoting_lit"))

((sym_lit) @meta.symbol.syntax-quoted
  (#is? test.ancestorTypeNearerThan "syn_quoting_lit unquoting_lit")
  (#match? @meta.symbol.syntax-quoted "[^#]$"))

((sym_lit) @meta.symbol.generated
  (#is? test.ancestorTypeNearerThan "syn_quoting_lit unquoting_lit")
  (#match? @meta.symbol.generated "#$"))

;; Function calls
(list_lit
  "(" @punctuation.section.expression.begin (#is-not? test.descendantOfNodeWithData clojure.dismissTag)
  .
  (sym_lit) @keyword.control.conditional.cond (#match? @keyword.control.conditional.cond "^cond(|.|-{1,2}>)$"))

;; Other function calls
(anon_fn_lit
 "(" @punctuation.section.expression.begin (#is-not? test.descendantOfNodeWithData "clojure.dismissTag")
 .
 (sym_lit) @entity.name.function @meta.expression
 ")" @punctuation.section.expression.end)

(list_lit
 "(" @punctuation.section.expression.begin (#is-not? test.descendantOfNodeWithData "clojure.dismissTag")
 .
 (sym_lit) @entity.name.function @meta.expression
 ")" @punctuation.section.expression.end)

; NS things like require
((sym_name) @meta.symbol (#eq? @meta.symbol "import") (#is-not? test.descendantOfNodeWithData "clojure.dismissTag")) @keyword.control
((sym_name) @meta.symbol (#eq? @meta.symbol "require") (#is-not? test.descendantOfNodeWithData "clojure.dismissTag")) @keyword.control

;; USE
((sym_name)
 @meta.symbol
 (#eq? @meta.symbol "use")
 (#is? test.config language-clojure.markDeprecations)
 (#is-not? test.descendantOfNodeWithData clojure.dismissTag))
@invalid.deprecated

((sym_name)
 @meta.symbol
 (#eq? @meta.symbol "use")
 (#is-not? test.config language-clojure.markDeprecations)
 (#is-not? test.descendantOfNodeWithData clojure.dismissTag))
@keyword.control

;; Namespace declaration
((list_lit
  "(" @punctuation.section.expression.begin (#is-not? test.descendantOfNodeWithData "clojure.dismissTag")
  .
  (sym_lit) @meta.definition.global @keyword.control
    (#eq? @meta.definition.global "ns")
  .
  ; We need to distinguish this `@meta.definition.global` from the one above or
  ; else this query will fail.
  (sym_lit) @meta.definition.global.__TEXT__ @entity.global
  ")" @punctuation.section.expression.end)
 @meta.namespace.clojure
 (#set! isNamespace true))

(list_lit
  "("
  .
  (kwd_lit) @invalid.deprecated (#eq? @invalid.deprecated ":use")
  (#is? test.config language-clojure.markDeprecations)
  (#is? test.descendantOfNodeWithData isNamespace))

;; Definition
(list_lit
 "(" @punctuation.section.expression.begin (#is-not? test.descendantOfNodeWithData "clojure.dismissTag")
 .
 (sym_lit) @keyword.control (#match? @keyword.control "^def(on[^\s]*|test|macro|n|n-|protocol|record|struct|)$")
 .
 (sym_lit) @meta.definition.global @entity.global
 ")" @punctuation.section.expression.end)

(list_lit
 "(" @punctuation.section.expression.begin (#is-not? test.descendantOfNodeWithData "clojure.dismissTag")
 .
 (sym_lit) @keyword.control (#match? @keyword.control "/def")
 .
 (sym_lit) @meta.definition.global @entity.global
 ")" @punctuation.section.expression.end)

;; Comment form ("Rich" comments)
((list_lit
  "(" @punctuation.section.expression.begin
  .
  (sym_lit) @meta.definition.global @keyword.control (#eq? @keyword.control "comment")
  ")" @punctuation.section.expression.end)
 @comment.block.clojure
 (#is? test.config language-clojure.commentTag)
 (#set! clojure.dismissTag true))

(list_lit
 "(" @punctuation.section.expression.begin
 .
 (sym_lit) @keyword.control (#eq? @keyword.control "comment")
 (#is-not? test.config language-clojure.commentTag)
 ")" @punctuation.section.expression.end)
