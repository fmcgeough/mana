defmodule BlockchainTest do
  use ExUnit.Case

  import EthCommonTest.Helpers

  alias Blockchain.Chain
  alias EthCommonTest.BlockchainTestRunner

  doctest Blockchain

  @failing_byzantium_tests File.read!(System.cwd() <> "/test/support/byzantium_failing_tests.txt")
  @failing_constantinople_tests File.read!(
                                  System.cwd() <> "/test/support/constantinople_failing_tests.txt"
                                )

  @failing_tests %{
    "Frontier" => [
      "bcExploitTest/DelegateCallSpam.json",
      "bcExploitTest/ShanghaiLove.json",
      "bcExploitTest/StrangeContractCreation.json",
      "bcExploitTest/SuicideIssue.json",
      "bcGasPricerTest/highGasUsage.json",
      "bcGasPricerTest/notxs.json",
      "bcUncleTest/EqualUncleInTwoDifferentBlocks.json",
      "bcUncleTest/InChainUncle.json",
      "bcUncleTest/InChainUncleFather.json",
      "bcUncleTest/InChainUncleGrandPa.json",
      "bcUncleTest/InChainUncleGreatGrandPa.json",
      "bcUncleTest/InChainUncleGreatGreatGrandPa.json",
      "bcUncleTest/InChainUncleGreatGreatGreatGrandPa.json",
      "bcUncleTest/InChainUncleGreatGreatGreatGreatGrandPa.json",
      "bcUncleTest/UncleIsBrother.json",
      "bcUncleTest/oneUncle.json",
      "bcUncleTest/oneUncleGeneration2.json",
      "bcUncleTest/oneUncleGeneration3.json",
      "bcUncleTest/oneUncleGeneration4.json",
      "bcUncleTest/oneUncleGeneration5.json",
      "bcUncleTest/oneUncleGeneration6.json",
      "bcUncleTest/oneUncleGeneration7.json",
      "bcUncleTest/threeUncle.json",
      "bcUncleTest/twoEqualUncle.json",
      "bcUncleTest/twoUncle.json",
      "bcUncleTest/uncleHeaderAtBlock2.json",
      "bcUncleTest/uncleHeaderWithGeneration0.json",
      "bcUncleTest/uncleWithSameBlockNumber.json",
      "bcValidBlockTest/ExtraData32.json",
      "bcValidBlockTest/RecallSuicidedContract.json",
      "bcValidBlockTest/RecallSuicidedContractInOneBlock.json",
      "bcValidBlockTest/SimpleTx.json",
      "bcValidBlockTest/SimpleTx3.json",
      "bcValidBlockTest/SimpleTx3LowS.json",
      "bcValidBlockTest/callRevert.json",
      "bcValidBlockTest/createRevert.json",
      "bcValidBlockTest/dataTx.json",
      "bcValidBlockTest/dataTx2.json",
      "bcValidBlockTest/diff1024.json",
      "bcValidBlockTest/gasLimitTooHigh.json",
      "bcValidBlockTest/gasLimitTooHigh2.json",
      "bcValidBlockTest/gasPrice0.json",
      "bcValidBlockTest/log1_correct.json",
      "bcValidBlockTest/timeDiff0.json",
      "bcValidBlockTest/timeDiff12.json",
      "bcValidBlockTest/timeDiff13.json",
      "bcValidBlockTest/timeDiff14.json",
      "bcValidBlockTest/txEqualValue.json",
      "bcValidBlockTest/txOrder.json",
      "bcWalletTest/wallet2outOf3txs.json",
      "bcWalletTest/wallet2outOf3txs2.json",
      "bcWalletTest/wallet2outOf3txsRevoke.json",
      "bcWalletTest/wallet2outOf3txsRevokeAndConfirmAgain.json"
    ],
    "Homestead" => [
      "bcExploitTest/DelegateCallSpam.json",
      "bcExploitTest/ShanghaiLove.json",
      "bcExploitTest/StrangeContractCreation.json",
      "bcExploitTest/SuicideIssue.json",
      "bcGasPricerTest/highGasUsage.json",
      "bcGasPricerTest/notxs.json",
      "bcUncleTest/EqualUncleInTwoDifferentBlocks.json",
      "bcUncleTest/InChainUncle.json",
      "bcUncleTest/InChainUncleFather.json",
      "bcUncleTest/InChainUncleGrandPa.json",
      "bcUncleTest/InChainUncleGreatGrandPa.json",
      "bcUncleTest/InChainUncleGreatGreatGrandPa.json",
      "bcUncleTest/InChainUncleGreatGreatGreatGrandPa.json",
      "bcUncleTest/UncleIsBrother.json",
      "bcUncleTest/oneUncle.json",
      "bcUncleTest/oneUncleGeneration2.json",
      "bcUncleTest/oneUncleGeneration3.json",
      "bcUncleTest/oneUncleGeneration4.json",
      "bcUncleTest/oneUncleGeneration5.json",
      "bcUncleTest/oneUncleGeneration6.json",
      "bcUncleTest/oneUncleGeneration7.json",
      "bcUncleTest/threeUncle.json",
      "bcUncleTest/twoEqualUncle.json",
      "bcUncleTest/twoUncle.json",
      "bcUncleTest/uncleHeaderAtBlock2.json",
      "bcUncleTest/uncleHeaderWithGeneration0.json",
      "bcUncleTest/uncleWithSameBlockNumber.json",
      "bcValidBlockTest/ExtraData32.json",
      "bcValidBlockTest/RecallSuicidedContract.json",
      "bcValidBlockTest/RecallSuicidedContractInOneBlock.json",
      "bcValidBlockTest/SimpleTx.json",
      "bcValidBlockTest/SimpleTx3.json",
      "bcValidBlockTest/SimpleTx3LowS.json",
      "bcValidBlockTest/callRevert.json",
      "bcValidBlockTest/createRevert.json",
      "bcValidBlockTest/dataTx.json",
      "bcValidBlockTest/dataTx2.json",
      "bcValidBlockTest/diff1024.json",
      "bcValidBlockTest/gasLimitTooHigh.json",
      "bcValidBlockTest/gasLimitTooHigh2.json",
      "bcValidBlockTest/gasPrice0.json",
      "bcValidBlockTest/log1_correct.json",
      "bcValidBlockTest/timeDiff0.json",
      "bcValidBlockTest/timeDiff12.json",
      "bcValidBlockTest/timeDiff13.json",
      "bcValidBlockTest/timeDiff14.json",
      "bcValidBlockTest/txEqualValue.json",
      "bcValidBlockTest/txOrder.json",
      "bcWalletTest/wallet2outOf3txs.json",
      "bcWalletTest/wallet2outOf3txs2.json",
      "bcWalletTest/wallet2outOf3txsRevoke.json",
      "bcWalletTest/wallet2outOf3txsRevokeAndConfirmAgain.json"
    ],
    "TangerineWhistle" => [
      "bcExploitTest/DelegateCallSpam.json",
      "bcExploitTest/ShanghaiLove.json",
      "bcExploitTest/StrangeContractCreation.json",
      "bcExploitTest/SuicideIssue.json",
      "bcGasPricerTest/highGasUsage.json",
      "bcGasPricerTest/notxs.json",
      "bcUncleTest/EqualUncleInTwoDifferentBlocks.json",
      "bcUncleTest/InChainUncle.json",
      "bcUncleTest/InChainUncleFather.json",
      "bcUncleTest/InChainUncleGrandPa.json",
      "bcUncleTest/InChainUncleGreatGrandPa.json",
      "bcUncleTest/InChainUncleGreatGreatGrandPa.json",
      "bcUncleTest/InChainUncleGreatGreatGreatGrandPa.json",
      "bcUncleTest/UncleIsBrother.json",
      "bcUncleTest/oneUncle.json",
      "bcUncleTest/oneUncleGeneration2.json",
      "bcUncleTest/oneUncleGeneration3.json",
      "bcUncleTest/oneUncleGeneration4.json",
      "bcUncleTest/oneUncleGeneration5.json",
      "bcUncleTest/oneUncleGeneration6.json",
      "bcUncleTest/oneUncleGeneration7.json",
      "bcUncleTest/threeUncle.json",
      "bcUncleTest/twoEqualUncle.json",
      "bcUncleTest/twoUncle.json",
      "bcUncleTest/uncleHeaderAtBlock2.json",
      "bcUncleTest/uncleHeaderWithGeneration0.json",
      "bcUncleTest/uncleWithSameBlockNumber.json",
      "bcValidBlockTest/ExtraData32.json",
      "bcValidBlockTest/RecallSuicidedContract.json",
      "bcValidBlockTest/RecallSuicidedContractInOneBlock.json",
      "bcValidBlockTest/SimpleTx.json",
      "bcValidBlockTest/SimpleTx3.json",
      "bcValidBlockTest/SimpleTx3LowS.json",
      "bcValidBlockTest/callRevert.json",
      "bcValidBlockTest/createRevert.json",
      "bcValidBlockTest/dataTx.json",
      "bcValidBlockTest/dataTx2.json",
      "bcValidBlockTest/diff1024.json",
      "bcValidBlockTest/gasLimitTooHigh.json",
      "bcValidBlockTest/gasLimitTooHigh2.json",
      "bcValidBlockTest/gasPrice0.json",
      "bcValidBlockTest/log1_correct.json",
      "bcValidBlockTest/timeDiff0.json",
      "bcValidBlockTest/timeDiff12.json",
      "bcValidBlockTest/timeDiff13.json",
      "bcValidBlockTest/timeDiff14.json",
      "bcValidBlockTest/txEqualValue.json",
      "bcValidBlockTest/txOrder.json",
      "bcWalletTest/wallet2outOf3txs2.json",
      "bcWalletTest/wallet2outOf3txsRevoke.json",
      "bcWalletTest/wallet2outOf3txsRevokeAndConfirmAgain.json"
    ],
    "SpuriousDragon" => [
      "GeneralStateTests/stAttackTest/CrashingTransaction_d0g0v0.json",
      "GeneralStateTests/stBadOpcode/badOpcodes_d0g0v0.json",
      "GeneralStateTests/stCallCodes/call_OOG_additionalGasCosts1_d0g0v0.json",
      "GeneralStateTests/stCallCodes/callcodeDynamicCode_d0g0v0.json",
      "GeneralStateTests/stCallCreateCallCodeTest/createNameRegistratorPerTxs_d0g0v0.json",
      "GeneralStateTests/stCodeSizeLimit/codesizeInit_d0g0v0.json",
      "GeneralStateTests/stCodeSizeLimit/codesizeOOGInvalidSize_d0g0v0.json",
      "GeneralStateTests/stCodeSizeLimit/codesizeValid_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_AcreateB_BSuicide_BStore_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_ContractSSTOREDuringInit_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_EContractCreateEContractInInit_Tr_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_EContractCreateNEContractInInitOOG_Tr_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_EContractCreateNEContractInInit_Tr_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_EContract_ThenCALLToNonExistentAcc_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_EmptyContractAndCallIt_0wei_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_EmptyContractAndCallIt_1wei_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_EmptyContractWithBalance_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_EmptyContractWithStorageAndCallIt_0wei_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_EmptyContractWithStorageAndCallIt_1wei_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_EmptyContractWithStorage_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_EmptyContract_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CREATE_empty000CreateinInitCode_Transaction_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CreateCollisionToEmpty_d0g0v0.json",
      "GeneralStateTests/stCreateTest/CreateCollisionToEmpty_d0g0v1.json",
      "GeneralStateTests/stCreateTest/TransactionCollisionToEmpty_d0g0v0.json",
      "GeneralStateTests/stCreateTest/TransactionCollisionToEmpty_d0g0v1.json",
      "GeneralStateTests/stDelegatecallTestHomestead/delegatecodeDynamicCode_d0g0v0.json",
      "GeneralStateTests/stEIP158Specific/EXP_Empty_d0g0v0.json",
      "GeneralStateTests/stEIP158Specific/vitalikTransactionTest_d0g0v0.json",
      "GeneralStateTests/stInitCodeTest/CallContractToCreateContractAndCallItOOG_d0g0v0.json",
      "GeneralStateTests/stInitCodeTest/CallContractToCreateContractOOGBonusGas_d0g0v0.json",
      "GeneralStateTests/stInitCodeTest/CallContractToCreateContractOOG_d0g0v0.json",
      "GeneralStateTests/stInitCodeTest/CallContractToCreateContractWhichWouldCreateContractIfCalled_d0g0v0.json",
      "GeneralStateTests/stInitCodeTest/CallContractToCreateContractWhichWouldCreateContractInInitCode_d0g0v0.json",
      "GeneralStateTests/stInitCodeTest/CallRecursiveContract_d0g0v0.json",
      "GeneralStateTests/stInitCodeTest/CallTheContractToCreateEmptyContract_d0g0v0.json",
      "GeneralStateTests/stInitCodeTest/OutOfGasContractCreation_d1g1v0.json",
      "GeneralStateTests/stInitCodeTest/TransactionCreateStopInInitcode_d0g0v0.json",
      "GeneralStateTests/stMemExpandingEIP150Calls/CreateAndGasInsideCreateWithMemExpandingCalls_d0g0v0.json",
      "GeneralStateTests/stMemExpandingEIP150Calls/NewGasPriceForCodesWithMemExpandingCalls_d0g0v0.json",
      "GeneralStateTests/stNonZeroCallsTest/NonZeroValue_CALL_ToEmpty_d0g0v0.json",
      "GeneralStateTests/stNonZeroCallsTest/NonZeroValue_CALL_ToOneStorageKey_d0g0v0.json",
      "GeneralStateTests/stNonZeroCallsTest/NonZeroValue_SUICIDE_ToEmpty_d0g0v0.json",
      "GeneralStateTests/stNonZeroCallsTest/NonZeroValue_SUICIDE_ToOneStorageKey_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecover0_0input_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecover0_Gas2999_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecover0_NoGas_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecover0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecover0_gas3000_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecover0_overlappingInputOutput_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecover1_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecover2_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecover3_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecover80_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecoverH_prefixed0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecoverR_prefixed0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecoverS_prefixed0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecoverV_prefixed0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecoverV_prefixedf0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CALLCODEEcrecoverV_prefixedf0_d1g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecover0_0input_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecover0_Gas2999_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecover0_NoGas_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecover0_completeReturnValue_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecover0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecover0_gas3000_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecover0_overlappingInputOutput_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecover1_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecover2_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecover3_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecover80_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecoverCheckLengthWrongV_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecoverCheckLength_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecoverH_prefixed0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecoverR_prefixed0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecoverS_prefixed0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallEcrecoverV_prefixed0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallIdentitiy_0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallIdentitiy_1_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallIdentity_2_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallIdentity_3_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallIdentity_4_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallIdentity_4_gas17_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallIdentity_4_gas18_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallIdentity_5_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallRipemd160_0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallRipemd160_1_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallRipemd160_2_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallRipemd160_3_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallRipemd160_3_postfixed0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallRipemd160_3_prefixed0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallRipemd160_4_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallRipemd160_4_gas719_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallRipemd160_5_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallSha256_0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallSha256_1_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallSha256_2_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallSha256_3_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallSha256_3_postfix0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallSha256_3_prefix0_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallSha256_4_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallSha256_4_gas99_d0g0v0.json",
      "GeneralStateTests/stPreCompiledContracts2/CallSha256_5_d0g0v0.json",
      "GeneralStateTests/stQuadraticComplexityTest/Create1000Byzantium_d0g1v0.json",
      "GeneralStateTests/stQuadraticComplexityTest/Create1000_d0g1v0.json",
      "GeneralStateTests/stRecursiveCreate/recursiveCreateReturnValue_d0g0v0.json",
      "GeneralStateTests/stRecursiveCreate/recursiveCreate_d0g0v0.json",
      "GeneralStateTests/stRefundTest/refund50percentCap_d0g0v0.json",
      "GeneralStateTests/stRefundTest/refund_multimpleSuicide_d0g0v0.json",
      "GeneralStateTests/stRefundTest/refund_singleSuicide_d0g0v0.json",
      "GeneralStateTests/stRevertTest/LoopCallsDepthThenRevert2_d0g0v0.json",
      "GeneralStateTests/stRevertTest/LoopCallsDepthThenRevert3_d0g0v0.json",
      "GeneralStateTests/stRevertTest/RevertDepthCreateOOG_d1g1v0.json",
      "GeneralStateTests/stRevertTest/RevertDepthCreateOOG_d1g1v1.json",
      "GeneralStateTests/stRevertTest/RevertPrefoundEmpty_d0g0v0.json",
      "GeneralStateTests/stRevertTest/RevertPrefound_d0g0v0.json",
      "GeneralStateTests/stRevertTest/RevertRemoteSubCallStorageOOG2_d0g1v0.json",
      "GeneralStateTests/stRevertTest/RevertRemoteSubCallStorageOOG_d0g1v0.json",
      "GeneralStateTests/stSolidityTest/CreateContractFromMethod_d0g0v0.json",
      "GeneralStateTests/stSolidityTest/RecursiveCreateContractsCreate4Contracts_d0g0v0.json",
      "GeneralStateTests/stSolidityTest/RecursiveCreateContracts_d0g0v0.json",
      "GeneralStateTests/stSpecialTest/StackDepthLimitSEC_d0g0v0.json",
      "GeneralStateTests/stSpecialTest/deploymentError_d0g0v0.json",
      "GeneralStateTests/stSpecialTest/failed_tx_xcf416c53_d0g0v0.json",
      "GeneralStateTests/stSpecialTest/tx_e1c174e2_d0g0v0.json",
      "GeneralStateTests/stSystemOperationsTest/createNameRegistratorZeroMem2_d0g0v0.json",
      "GeneralStateTests/stSystemOperationsTest/createNameRegistratorZeroMemExpansion_d0g0v0.json",
      "GeneralStateTests/stSystemOperationsTest/createNameRegistratorZeroMem_d0g0v0.json",
      "GeneralStateTests/stSystemOperationsTest/createNameRegistrator_d0g0v0.json",
      "GeneralStateTests/stSystemOperationsTest/doubleSelfdestructTest2_d0g0v0.json",
      "GeneralStateTests/stSystemOperationsTest/doubleSelfdestructTest_d0g0v0.json",
      "GeneralStateTests/stSystemOperationsTest/testRandomTest_d0g0v0.json",
      "GeneralStateTests/stTransactionTest/CreateMessageSuccess_d0g0v0.json",
      "GeneralStateTests/stTransactionTest/CreateTransactionSuccess_d0g0v0.json",
      "GeneralStateTests/stTransactionTest/EmptyTransaction2_d0g0v0.json",
      "GeneralStateTests/stTransactionTest/EmptyTransaction3_d0g0v0.json",
      "GeneralStateTests/stTransactionTest/Opcodes_TransactionInit_d120g0v0.json",
      "GeneralStateTests/stTransactionTest/Opcodes_TransactionInit_d124g0v0.json",
      "GeneralStateTests/stTransactionTest/StoreGasOnCreate_d0g0v0.json",
      "GeneralStateTests/stTransactionTest/TransactionSendingToEmpty_d0g0v0.json",
      "GeneralStateTests/stTransitionTest/createNameRegistratorPerTxsAfter_d0g0v0.json",
      "GeneralStateTests/stTransitionTest/createNameRegistratorPerTxsAt_d0g0v0.json",
      "GeneralStateTests/stTransitionTest/createNameRegistratorPerTxsBefore_d0g0v0.json",
      "GeneralStateTests/stWalletTest/dayLimitConstructionPartial_d0g0v0.json",
      "GeneralStateTests/stWalletTest/dayLimitConstruction_d0g0v0.json",
      "GeneralStateTests/stWalletTest/dayLimitConstruction_d0g1v0.json",
      "GeneralStateTests/stWalletTest/multiOwnedConstructionCorrect_d0g0v0.json",
      "GeneralStateTests/stWalletTest/walletConstructionOOG_d0g1v0.json",
      "GeneralStateTests/stWalletTest/walletConstructionPartial_d0g0v0.json",
      "GeneralStateTests/stWalletTest/walletConstruction_d0g0v0.json",
      "GeneralStateTests/stWalletTest/walletConstruction_d0g1v0.json",
      "GeneralStateTests/stZeroCallsTest/ZeroValue_CALL_d0g0v0.json",
      "GeneralStateTests/stZeroCallsTest/ZeroValue_SUICIDE_d0g0v0.json",
      "bcExploitTest/DelegateCallSpam.json",
      "bcExploitTest/ShanghaiLove.json",
      "bcExploitTest/StrangeContractCreation.json",
      "bcExploitTest/SuicideIssue.json",
      "bcGasPricerTest/RPC_API_Test.json",
      "bcGasPricerTest/highGasUsage.json",
      "bcGasPricerTest/notxs.json",
      "bcRandomBlockhashTest/randomStatetest403BC.json",
      "bcRandomBlockhashTest/randomStatetest8BC.json",
      "bcStateTests/OOGStateCopyContainingDeletedContract.json",
      "bcUncleTest/EqualUncleInTwoDifferentBlocks.json",
      "bcUncleTest/InChainUncle.json",
      "bcUncleTest/InChainUncleFather.json",
      "bcUncleTest/InChainUncleGrandPa.json",
      "bcUncleTest/InChainUncleGreatGrandPa.json",
      "bcUncleTest/InChainUncleGreatGreatGrandPa.json",
      "bcUncleTest/InChainUncleGreatGreatGreatGrandPa.json",
      "bcUncleTest/UncleIsBrother.json",
      "bcUncleTest/oneUncle.json",
      "bcUncleTest/oneUncleGeneration2.json",
      "bcUncleTest/oneUncleGeneration3.json",
      "bcUncleTest/oneUncleGeneration4.json",
      "bcUncleTest/oneUncleGeneration5.json",
      "bcUncleTest/oneUncleGeneration6.json",
      "bcUncleTest/oneUncleGeneration7.json",
      "bcUncleTest/threeUncle.json",
      "bcUncleTest/twoEqualUncle.json",
      "bcUncleTest/twoUncle.json",
      "bcUncleTest/uncleHeaderAtBlock2.json",
      "bcUncleTest/uncleHeaderWithGeneration0.json",
      "bcUncleTest/uncleWithSameBlockNumber.json",
      "bcValidBlockTest/ExtraData32.json",
      "bcValidBlockTest/RecallSuicidedContract.json",
      "bcValidBlockTest/RecallSuicidedContractInOneBlock.json",
      "bcValidBlockTest/SimpleTx.json",
      "bcValidBlockTest/SimpleTx3.json",
      "bcValidBlockTest/SimpleTx3LowS.json",
      "bcValidBlockTest/callRevert.json",
      "bcValidBlockTest/createRevert.json",
      "bcValidBlockTest/dataTx.json",
      "bcValidBlockTest/dataTx2.json",
      "bcValidBlockTest/diff1024.json",
      "bcValidBlockTest/gasLimitTooHigh.json",
      "bcValidBlockTest/gasLimitTooHigh2.json",
      "bcValidBlockTest/gasPrice0.json",
      "bcValidBlockTest/log1_correct.json",
      "bcValidBlockTest/timeDiff0.json",
      "bcValidBlockTest/timeDiff12.json",
      "bcValidBlockTest/timeDiff13.json",
      "bcValidBlockTest/timeDiff14.json",
      "bcValidBlockTest/txEqualValue.json",
      "bcValidBlockTest/txOrder.json",
      "bcWalletTest/wallet2outOf3txs.json",
      "bcWalletTest/wallet2outOf3txs2.json",
      "bcWalletTest/wallet2outOf3txsRevoke.json",
      "bcWalletTest/wallet2outOf3txsRevokeAndConfirmAgain.json",
      "bcWalletTest/walletReorganizeOwners.json"
    ],
    "Byzantium" => String.split(@failing_byzantium_tests, "\n"),
    "Constantinople" => String.split(@failing_constantinople_tests, "\n"),
    # the rest are not implemented yet
    "EIP158ToByzantiumAt5" => [],
    "FrontierToHomesteadAt5" => [],
    "HomesteadToDaoAt5" => [],
    "HomesteadToEIP150At5" => []
  }

  @ten_minutes 1000 * 60 * 10
  @num_test_groups 10

  @tag :ethereum_common_tests
  @tag :blockchain_common_tests
  test "runs blockchain tests" do
    grouped_test_per_fork()
    |> Task.async_stream(&run_tests(&1), timeout: @ten_minutes)
    |> Enum.flat_map(fn {:ok, results} -> results end)
    |> Enum.filter(&failing_test?/1)
    |> make_assertions()
  end

  defp failing_test?({:fail, _}), do: true
  defp failing_test?(_), do: false

  defp grouped_test_per_fork do
    for fork <- forks_with_existing_implementation(),
        test_group <- split_tests_into_groups(@num_test_groups),
        do: {fork, test_group}
  end

  defp split_tests_into_groups(num_groups_desired) do
    all_tests = tests()
    test_count = Enum.count(all_tests)
    tests_per_group = div(test_count, num_groups_desired)

    Enum.chunk_every(all_tests, tests_per_group)
  end

  defp run_tests({fork, tests}) do
    tests
    |> Stream.reject(&known_fork_failures?(&1, fork))
    |> Enum.flat_map(fn json_test_path ->
      BlockchainTestRunner.run(json_test_path, fork)
    end)
  end

  defp known_fork_failures?(json_test_path, fork) do
    hardfork_failing_tests = Map.fetch!(@failing_tests, fork)

    Enum.any?(hardfork_failing_tests, fn failing_test ->
      String.contains?(json_test_path, failing_test)
    end)
  end

  defp forks_with_existing_implementation do
    @failing_tests
    |> Map.keys()
    |> Enum.reject(&fork_without_implementation?/1)
  end

  defp fork_without_implementation?(fork) do
    fork
    |> Chain.test_config()
    |> is_nil()
  end

  defp make_assertions([]), do: assert(true)
  defp make_assertions(failing_tests), do: refute(true, failure_message(failing_tests))

  defp failure_message(failing_tests) do
    total_failures = Enum.count(failing_tests)

    error_messages =
      failing_tests
      |> Enum.map(&single_error_message/1)
      |> Enum.join("\n")

    """
    Block hash mismatch for the following tests:
    #{error_messages}
    -----------------
    Total failures: #{inspect(total_failures)}
    """
  end

  defp single_error_message({:fail, {fork, test_name, expected, actual}}) do
    "[#{fork}] #{test_name}: expected #{inspect(expected)}, but received #{inspect(actual)}"
  end

  defp tests do
    ethereum_common_tests_path()
    |> Path.join("/BlockchainTests/**/*.json")
    |> Path.wildcard()
    |> Enum.sort()
  end
end
