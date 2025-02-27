// Created by Cihat Gündüz on 28.01.19.

import Foundation
import SwiftSyntax
import HandySwift

class SupportedLanguagesReader: SyntaxVisitor {
    let typeName: String
    var caseToLangCode: [String: String] = [:]

    init(typeName: String) {
        self.typeName = typeName
    }

    override func visit(_ enumDeclaration: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        if enumDeclaration.identifier.text == self.typeName {
            return .visitChildren
        }
        
        if enumDeclaration.identifier.text == "SupportedLanguage" {
            return .visitChildren
        } else {
            return .skipChildren
        }
    }

    override func visit(_ enumCaseElement: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
        if let langCodeLiteral = enumCaseElement.rawValue?.value as? StringLiteralExprSyntax {
            caseToLangCode[enumCaseElement.identifier.text] = langCodeLiteral.text
        }

        return .skipChildren
    }
}
