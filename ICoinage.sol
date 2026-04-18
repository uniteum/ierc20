// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {IERC20Metadata} from "./IERC20Metadata.sol";

/**
 * @title ICoinage
 * @notice Interface for an ERC-20 token maker.
 * @author Paul Reinholdtsen (reinholdtsen.eth)
 */
interface ICoinage {
    /**
     * @notice Checks whether a token with the given parameters has already been deployed.
     * @param maker  The address of the token maker.
     * @param name   The token name.
     * @param symbol The token symbol.
     * @param supply The total supply.
     * @param salt   Caller-supplied salt used to distinguish otherwise identical deployments.
     * @return exists  `true` if the token already exists.
     * @return home The deterministic address of the token.
     * @return create2Salt The CREATE2 salt derived from `(maker, name, symbol, supply, salt)`.
     */
    function made(address maker, string calldata name, string calldata symbol, uint256 supply, bytes32 salt)
        external
        view
        returns (bool exists, address home, bytes32 create2Salt);

    /**
     * @notice Deploys a new or returns an existing ERC-20 token.
     * @param name   The token name.
     * @param symbol The token symbol.
     * @param supply The initial supply to mint.
     * @param salt   Caller-supplied salt used to distinguish otherwise identical deployments.
     * @return token The address of the (possibly pre-existing) token.
     */
    function make(string calldata name, string calldata symbol, uint256 supply, bytes32 salt)
        external
        returns (IERC20Metadata token);

    /**
     * @notice Emitted when a new ERC-20 token is created via {make}.
     * @param maker       The address that called {make}.
     * @param token       The newly created token.
     * @param name        The token name.
     * @param symbol      The token symbol.
     * @param totalSupply The supply minted to `maker`.
     */
    event Made(address indexed maker, IERC20Metadata indexed token, string name, string symbol, uint256 totalSupply);

    /**
     * @notice Thrown when the token name is empty.
     */
    error Nameless();

    /**
     * @notice Thrown when the token symbol is empty.
     */
    error Symbolless();

    /**
     * @notice Thrown when the supply is zero.
     */
    error Nothing();

    /**
     * @notice Thrown when a function restricted to the maker is called by another address.
     */
    error Unauthorized();
}
