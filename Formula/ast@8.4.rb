# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT84 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.1.tgz"
  sha256 "0c55e09a4da43b9cc1da72ecb4ae892941f73e157b73d46326bc6a5ed7fc44b1"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "f5844a875050d66090ab6291f1383b1705d1332619d1f67997721915a1369bae"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "280940f7d658b86f71f34b763940ef70f737ed6f825670cd226ef0399f2f03a5"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1b905e5609a37521926a97a0853dae957bdf42a515a536b72b660b7d90cd89fb"
    sha256 cellar: :any_skip_relocation, ventura:        "fd96bdc0f40c6812d7bab2b7e5e6b2b938db627e063d6667ff420fb2d0627fbd"
    sha256 cellar: :any_skip_relocation, monterey:       "581515a2c1042d744b6cf7e3155ef370fc9e85ac78e5baf8df89ff5a7de59832"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ec110b3c653298e79fa78b88558c6aa685b70735a55665c4015edc11e5e74bb8"
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
