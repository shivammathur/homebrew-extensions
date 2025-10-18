# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT70 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.0.16.tgz"
  sha256 "45bda34b780c4661ce77cf65cd8a504fb56526d4b456edcc97d791c86f3879ce"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "40d1891308efaa0ba21162f58d3759387ffbe523f4866c77eb17f8bab9649432"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bbcb39d66acad9844df56f80d94b2c2e3c5b9e2c7bf645da88dac679afaf0d76"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c1057bfcb84f2278562267a58aa1c938762cfec88e70c61ba5990bb8a2118489"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e81353cdf601d05a40845833d8b86ec96d01a1dcd8d115ea96b80bfad4791c1a"
    sha256 cellar: :any_skip_relocation, ventura:        "17f4d79275c743257549589deddf3344ebe5a0bd1eb1d52192406ec0c7485fd2"
    sha256 cellar: :any_skip_relocation, monterey:       "d9905d1471881a66742347725247f7e7f4708358079a7de2a538a79edb774b8a"
    sha256 cellar: :any_skip_relocation, big_sur:        "d1ee18c873c77bdd3f9ea359f018c004f3a640fab688332a4c77dc26678c2d57"
    sha256 cellar: :any_skip_relocation, catalina:       "297a0ee4b8224b5ea1327eea268803b3049b938a8f9f2c303fb98236e5304b25"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "75403a5d20a3398a1b9871d7bb2807c851982887722b86b4a35b677bd6d07ce2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3ed5c4568be68af927f37761d8282804ec80bfb858ddc276e5c5e9ee1a9245ce"
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
