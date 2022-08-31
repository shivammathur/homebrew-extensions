# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT83 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.0.tgz"
  sha256 "ee3d4f67e24d82e4d340806a24052012e4954d223122949377665427443e6d13"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e52631cb9b9d0c8047bcb8553e97ecaf66d4775a0ff72b94db7f45960902973f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8fa309aa83ecf2b43826f2df5bab30d5c19b76457390900b909c33463c583958"
    sha256 cellar: :any_skip_relocation, monterey:       "1af5cb55c38d028784e238f54d6b63d386b0c1c2277b40fe816192c156a32143"
    sha256 cellar: :any_skip_relocation, big_sur:        "4ffffcc9f58822377ee2f405145518f2e8926b31b35b71f5fba978f956b23d60"
    sha256 cellar: :any_skip_relocation, catalina:       "2daa91a908ea73a980b291a090fed18236407e02626f262779266b35e494da30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "95dcc77de172a65295f078a053dac2305cc74ff563d54c0131cbbdaa1a1f024a"
  end

  def install
    Dir.chdir "ast-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ast"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
