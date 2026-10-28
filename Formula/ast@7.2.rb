# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT72 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.4.tgz"
  sha256 "28728fb8bfd8b0eddccd241f92f0be0a45d83250e5a0cd6e1876c0c533ab3658"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "37ca0bb223b3c0ad20a99fcf4b9f890416e0215c9c8643cac15a36c967e82485"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "89b4e7d5d2b9bf436ed8873b477d637f34f739a78dc0a634d28a3bce8ba77d21"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "d5509352d8e11222edb7459ca15fde25404a41ba170871c82bb9d99ee2b31b41"
    sha256 cellar: :any,                 arm64_linux:       "7f0e13bb63e69bc1cea449458256a0b8e7a1e0d858cc0d7861cd2c399bd33aef"
    sha256 cellar: :any,                 x86_64_linux:      "79307e4397284761547fd853237dafbf8d9f21dadbd33c573cf82fb3554b895b"
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
