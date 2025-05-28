# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT83 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.2.tgz"
  sha256 "8742427ff7c07ba93f940968f7363972ea040d97d847da3b79b4283c2a369dea"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "1ef0168b873e7a4ad4a9b2ff65a8492538dbbb4c4d7445410affb4e438f241b4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ce77d34cfdac5df284559a1482dd78fabdd052d509a03e261ce8625cfaade35e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a72a1c892fcd0373d3f2003f3620ed67de32321137ca63e73bc54f5e77b4c83f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8419c9cd1869963416343416dc009ca73b6d4190d0094fe2d0080ffe5b75f065"
    sha256 cellar: :any_skip_relocation, ventura:        "e973d76d9e1967e35460390b36a89cb4124598df9e4c00de14a795b0b004891b"
    sha256 cellar: :any_skip_relocation, monterey:       "3b173965e221f579add886108ee36dd4100c575541bc4bba57badf4eb3782af2"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "cdb32a929dd1b07e72f542a5e0e9a0f74cf0aeeedad6f1c7095f15abec588d78"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7922fd57d2d206d89ae330f417a1a413b5ce199d1833f9c4c6adb149db3c4fe8"
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
