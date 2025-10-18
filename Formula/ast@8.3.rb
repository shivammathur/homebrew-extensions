# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT83 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.3.tgz"
  sha256 "528b54aabcfce6bf0e94b5940a73cca357d4a52fad9fef4cd4dc025abc1a9fbd"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5072400ae4095f121f201d39a7c4f02a401397cf5157057eb99826c94ff565b5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9e1b5abcc63e8e23c6ebcdd0cc2805805e14607a67edd1a5dd4d5326adb18286"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "75a1ed037119afdfc74308f66a24fdb3f23c1ed0d71642e8d9e80ae9dd0984b3"
    sha256 cellar: :any_skip_relocation, sonoma:        "88088df29b3fb64939ae60e6aa10b713c988eeadad4f1235930fa745f00dff16"
    sha256 cellar: :any_skip_relocation, ventura:       "2d844822cd00b022683987318ced2b2fa822c27733e59ce6c4d9bf3f351643b9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b70cf588445ea9bb351a43b35535f246c40350e10e8f35f8808c6b8ca1efea6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01ecf7c48685bc84cefedd848e44174e2a6b564571426e0f2045157352c7b4e2"
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
