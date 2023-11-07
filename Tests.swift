import XCTest

class VirtualBankSystemTests: XCTestCase {
    var virtualBankSystem: VirtualBankSystem!
    var bankAccount: BankAccount!

    override func setUp() {
        virtualBankSystem = VirtualBankSystem()
        bankAccount = BankAccount()
    }

    func testAccountOpening() {
        virtualBankSystem.makeAccount(numberPadKey: 1)
        XCTAssertEqual(virtualBankSystem.accountType, "debit")
        
        virtualBankSystem.makeAccount(numberPadKey: 2)
        XCTAssertEqual(virtualBankSystem.accountType, "credit")
        
        // Test invalid input
        virtualBankSystem.makeAccount(numberPadKey: 3)
        XCTAssertEqual(virtualBankSystem.accountType, "")  // Should not change
    }

    func testDebitDepositAndWithdraw() {
        virtualBankSystem.accountType = "debit"
        
        virtualBankSystem.transferMoney(transferType: "deposit", transferAmount: 50, bankAccount: &bankAccount)
        XCTAssertEqual(bankAccount.debitBalance, 50)

        virtualBankSystem.transferMoney(transferType: "withdraw", transferAmount: 30, bankAccount: &bankAccount)
        XCTAssertEqual(bankAccount.debitBalance, 20)

        // Testing insufficient funds for withdrawal
        virtualBankSystem.transferMoney(transferType: "withdraw", transferAmount: 25, bankAccount: &bankAccount)
        XCTAssertEqual(bankAccount.debitBalance, 20)  // Should not change
    }

    func testCreditDepositAndWithdraw() {
        virtualBankSystem.accountType = "credit"

        virtualBankSystem.transferMoney(transferType: "deposit", transferAmount: 50, bankAccount: &bankAccount)
        XCTAssertEqual(bankAccount.creditBalance, 50)

        virtualBankSystem.transferMoney(transferType: "withdraw", transferAmount: 30, bankAccount: &bankAccount)
        XCTAssertEqual(bankAccount.creditBalance, 20)

        // Test insufficient credit for withdrawal
        virtualBankSystem.transferMoney(transferType: "withdraw", transferAmount: 25, bankAccount: &bankAccount)
        XCTAssertEqual(bankAccount.creditBalance, 20)  // Should not change
    }

    func testAccountBalanceCheck() {
        virtualBankSystem.accountType = "debit"
        virtualBankSystem.checkBalance(bankAccount: bankAccount)
        
        virtualBankSystem.accountType = "credit"
        virtualBankSystem.checkBalance(bankAccount: bankAccount)
    }

    func testClosedSystem() {
        virtualBankSystem.isOpened = false
        XCTAssertEqual(virtualBankSystem.isOpened, false)
    }
}
