# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT83 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.1.tgz"
  sha256 "0c55e09a4da43b9cc1da72ecb4ae892941f73e157b73d46326bc6a5ed7fc44b1"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2ee5693f0326449d9eaab0c4a90fbfafe296ff3cfefdf2740dad175f80b0ab3f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3b54ce42af9dd7b07018f34d0813c79dcd1aefe6bc423c01b8daaf28472e2bd4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "825973d5827d97120ca0f788c04bdaf164c44dc4a98c1d030c6f36a6974a9287"
    sha256 cellar: :any_skip_relocation, ventura:        "0d4f5160cd88c5d0cbf9eea2463374af058e3f80eb721eb40cb3e0a9b208ad8a"
    sha256 cellar: :any_skip_relocation, monterey:       "fcd1315494d93ba72c57ffec7ccde43bb75ac638b9b6686c4a819ced7d4857ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6ac9556d55939f1c9fb28e1393a0da2c43e3f40bfb2b4710f87706b8d4e7776d"
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
