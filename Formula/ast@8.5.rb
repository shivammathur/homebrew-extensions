# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "d91227c53f9a62912515bdeeb66267b3d82cc11965a3344b9ed0ac69133e3a43"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "25fd3230e5c8eb33767c655bea1790d44c5b369410242a01004125ccef0f9f1d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "4471b67d4c5e35c1f242b7dcf17f614efb57f9e28fa1f5860304dfe5c5992238"
    sha256 cellar: :any,                 arm64_linux:       "f2ecf20142260b5041e2088ae828c2cf7516b9afcffccd90255916aba72c205d"
    sha256 cellar: :any,                 x86_64_linux:      "17d485e17e0946fb532f74a22a7f0c17080295686aa1b60566284123d424b5a7"
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
