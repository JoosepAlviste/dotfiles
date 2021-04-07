const getSeverity = message => {
  switch (message.severity) {
    case 2:
      return 'e';
    case 1:
      return 'w';
    default:
      return 'e';
  }
}

/**
 * The Vim ESLint formatter is built to allow better handling of ESLint errors
 * within Vim (especially Neovim's built-in LSP).
 *
 * EFM can read the errors with this error format: "%f:%l:%c:%t: %m".
 *
 * This is basically the "unix" formatter that's built into ESLint, but with
 * added severity.
 */
module.exports = function(results) {
    let output = '';

    results.forEach(result => {
        const messages = result.messages;
        messages.forEach(message => {
            output += `${result.filePath}:`;
            output += `${message.line || 1}:`;
            output += `${message.column || 0}:`;
            output += `${getSeverity(message)}:`;
            output += ` ${message.message} `;
            output += `[${message.ruleId ? message.ruleId : ''}]`;
            output += '\n';
        });
    });

    return output;
};
