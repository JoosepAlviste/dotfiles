#!/usr/bin/env python

# Script to swap which workspace is on which monitor (output)
# Might not work as expected if at least one workspace is empty

import i3, time

def main():
    outputs = i3.get_outputs()
    workspaces = i3.get_workspaces()

    # Only include outputs with active: True
    workspaces = [o['current_workspace'] for o in outputs if o['active'] is True]

    if len(workspaces) == 2:
        i3.command('workspace', workspaces[0])
        i3.command('move', 'workspace to output right')

        # Hacky fix for race condition
        time.sleep(0.01)

        i3.command('workspace', workspaces[1])
        i3.command('move', 'workspace to output left')
    elif len(outputs) < 2:
        print('Not enough outputs')
    else:
        print('Too many outputs')

if __name__ == '__main__':
    main()
