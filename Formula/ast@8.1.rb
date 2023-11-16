# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT81 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.1.tgz"
  sha256 "0c55e09a4da43b9cc1da72ecb4ae892941f73e157b73d46326bc6a5ed7fc44b1"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2939bf27170d4e7d4f378efaf555546b8b8ad1630641fd5cb76b9c664d55cbdb"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "008b500e14f893211a0171b457b5f1fc26f174e1a48325cf41e462f652f2c103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d6aa639c63c12c599d874e16dde32e8a5684ffe042819174e70e9d0e223bca18"
    sha256 cellar: :any_skip_relocation, ventura:        "5afcc5a5bee35384841377af4b4a7019390666d75b4c49810aff63b84b7338eb"
    sha256 cellar: :any_skip_relocation, monterey:       "e1454d7d40984418f83af211e82e2398f0d486d46002d14904e25bcfeba892e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b1f6b3579a251ff88e8b25963467b254d913623ad7c1926c535fcf01fa2a564"
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
