# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT74 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.3.tgz"
  sha256 "528b54aabcfce6bf0e94b5940a73cca357d4a52fad9fef4cd4dc025abc1a9fbd"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "2167505b8ea7a95a3b13ca9b24c39413e64d94011205aacda9fca52c1d2cbd54"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "89817ce5af9b0703b7565df3769e99e74c1b673fe543870cfd5f3cf64c88ed32"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b2d07c5957c50accbe894ea73e97d064e755243056933dc977a737ede9cfa2fc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6c2312fbad7e7daab84217b970c97cdd093c93133fba069e415d9ca245aa0a95"
    sha256 cellar: :any_skip_relocation, ventura:        "9f9a8646c04d144324167f15b77e1bd09543478ea44f620a619d22b7006018ff"
    sha256 cellar: :any_skip_relocation, monterey:       "a8da8e351f32f50e75267cfcd391a9a188a63af58f62201ee9ebaa588362b057"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "cbcd6a3cfdcb68dfeea1d2862842d717e8a8d4ae0baa145baebed06ad38e87ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d0a76efad3e3049ed6433a31eee88296bb61ffbd7ca0c545b1bde32d8955b591"
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
