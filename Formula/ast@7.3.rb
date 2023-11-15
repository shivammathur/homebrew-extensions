# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT73 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.1.tgz"
  sha256 "0c55e09a4da43b9cc1da72ecb4ae892941f73e157b73d46326bc6a5ed7fc44b1"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1c3a7808999cb427555e9e025d3f978b2a4afbf3da06d39cb4531b793651fa3b"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "37a7d6f65e0ed2e1c65e2fc8508ed1619a1f324859d28d98ceec5dca752b7d5c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c66d7ab788e30883f09765d41ab91ad66d7529bf4f9a7efe9bf927f26625698e"
    sha256 cellar: :any_skip_relocation, ventura:        "5047a5c0b94ab816abf3d740d01a71bf6e8bfce940630005c5ac309eb7292ca4"
    sha256 cellar: :any_skip_relocation, monterey:       "8b82a3c088c22aa7d886de2f196fcb39ad2c8f3b1cb300ebe5a769828b2eab5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "82c8216a5e3f721921be418725f1447ea1a1644edff3acd7389d5f00b0aa1747"
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
