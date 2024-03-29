# -*- coding: utf-8 -*-
# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import *

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

# You can import any python module as needed.
import os

# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!


class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()

# 参考: 
# https://github.com/ranger/ranger/wiki/Custom-Commands
# https://github.com/ranger/ranger/wiki/Integration-with-other-programs
# fasd
import ranger.api

old_hook_init = ranger.api.hook_init

def hook_init(fm):
    # def fasd_add():
    #     fm.execute_console("shell fasd --add '" + fm.thisfile.path + "'")
    # fm.signal_bind('execute.before', fasd_add)
    return old_hook_init(fm)

ranger.api.hook_init = hook_init

# class fasd(Command):
#     """
#     :fasd

#     Jump to directory using fasd
#     """
#     def execute(self):
#         import subprocess
#         arg = self.rest(1)
#         if arg:
#             directory = subprocess.check_output(["fasd", "-d"]+arg.split(), universal_newlines=True).strip()
#             self.fm.cd(directory)



class mkcd(Command):
    """
    :mkcd <dirname>

    Creates a directory with the name <dirname> and enters it.
    """

    def execute(self):
        from os.path import join, expanduser, lexists
        from os import makedirs
        import re

        dirname = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        if not lexists(dirname):
            makedirs(dirname)

            match = re.search('^/|^~[^/]*/', dirname)
            if match:
                self.fm.cd(match.group(0))
                dirname = dirname[match.end(0):]

            for m in re.finditer('[^/]+', dirname):
                s = m.group(0)
                if s == '..' or (s.startswith('.') and not self.fm.settings['show_hidden']):
                    self.fm.cd(s)
                else:
                    ## We force ranger to load content before calling `scout`.
                    self.fm.thisdir.load_content(schedule=False)
                    self.fm.execute_console('scout -ae ^{}$'.format(s))
        else:
            self.fm.notify("file/directory exists!", bad=True)

class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path
        fzf = self.fm.execute_command("fzf +m", universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

'''
自作コマンド
'''

# class fcd(Command):
#     """
#     :fcd

#     fasdの履歴からfzfで絞り込んで移動
#     参考: [bashでもfzf+fasdで簡単ディレクトリ移動](https://qiita.com/thesaitama/items/e139646ed6bc9c5dbf83)
#     """
#     def execute(self):
#         import subprocess
#         import os.path
#         fzf = self.fm.execute_command("fasd -d | fzf -1 -0 --no-sort --tac +m | sed 's/^[0-9,.]* *//'",
#                 shell=True, universal_newlines=True, stdout=subprocess.PIPE)
#         stdout, stderr = fzf.communicate()
#         if fzf.returncode == 0:
#             fzf_file = os.path.abspath(stdout.rstrip('\n'))
#             if os.path.isdir(fzf_file):
#                 self.fm.cd(fzf_file)
#             else:
#                 self.fm.select_file(fzf_file)

class z(Command):
    """
    :z

    zoxideがある時

    zoxideがない時
        fcdとおなじ.fasdの履歴からfzfで絞り込んで移動
        参考:
        [bashでもfzf+fasdで簡単ディレクトリ移動](https://qiita.com/thesaitama/items/e139646ed6bc9c5dbf83)
    """
    def execute(self):
        import subprocess
        import os.path
        import shutil

        # if shutil.which("zoxide"):
        # ↑ whichが見つからないというエラーが出たので一時的に無効化
        if True:
            query = self.fm.execute_command(
                "zoxide query -i",
                shell=True, universal_newlines=True,
                stdout=subprocess.PIPE)
        else:
            query = self.fm.execute_command(
                "fasd -d | fzf -1 -0 --no-sort --tac +m | sed 's/^[0-9,.]* *//'",
                shell=True, universal_newlines=True, stdout=subprocess.PIPE)

        stdout, _ = query.communicate()
        if query.returncode == 0 and stdout:
            query_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(query_file):
                self.fm.cd(query_file)
            else:
                self.fm.select_file(query_file)
