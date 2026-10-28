# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "7b13f4d13506f983849d5284f1ccb885d7523e2ca0a6c9cf9fec0f8ca2e8addf"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "d64cf80a3af6acf32d35ba31fd94e71c843007b5d5e37397a6df39d4bc18fe3e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "ddc02699932bef2710160ce3742a8fc15a7bbbae07c435a35f1ca452c108a436"
    sha256 cellar: :any,                 arm64_linux:       "c4c8c9addce355c385833adc0e0aeb84dfd527510b0b0bab0982cdcf5401e90e"
    sha256 cellar: :any,                 x86_64_linux:      "3fc76cb3aae7f896b3da5c2c6d5c2e80fab0bb056d8ba71e5ce588bd57838991"
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
