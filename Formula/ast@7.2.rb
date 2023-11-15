# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT72 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.1.tgz"
  sha256 "0c55e09a4da43b9cc1da72ecb4ae892941f73e157b73d46326bc6a5ed7fc44b1"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "dedd1159939d7bb53ad4db29e487340d73cca501a49a9cb4c479906174679a16"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4d8355c36e575a7687cc56b41655f4a4956a34ea602ad6e83b0e079ec2597232"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "972613d52675a277e71e05bf1f535798c2ceffa23b68e8e6b71480c1de2e0fc6"
    sha256 cellar: :any_skip_relocation, ventura:        "110d469c4739574953c6daea55bb26dcaab687e76060fa2a1a398fc68d3217d1"
    sha256 cellar: :any_skip_relocation, monterey:       "f76a5c59dc970425a71ac1b61f5fc032a49b327241faa7cefa7b206f402fa69f"
    sha256 cellar: :any_skip_relocation, big_sur:        "f41ccf2454245e263d7eb33b022d9020b6aa0d18a0b02d6e52294c66fe9f1ff9"
    sha256 cellar: :any_skip_relocation, catalina:       "f1ecf73b8f537638fb111dc31a19fe747003bac0e772e4275138c8c0e313ab69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3bc17d0266cffa3a2817a32bad1db1ae6796939b2b2af19e9871dfc2eb781e18"
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
