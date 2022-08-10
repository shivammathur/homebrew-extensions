# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT82 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.0.tgz"
  sha256 "ee3d4f67e24d82e4d340806a24052012e4954d223122949377665427443e6d13"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d517ea63c7c5ea34bbf13ee3d4b9ca6ab5d76a2507ae694acd5834033a2371d2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "36138728b9be5be5404f9edd54c563027d17539d04c0498a7c6e6d67406e57a2"
    sha256 cellar: :any_skip_relocation, monterey:       "1d231ab653bd9599086e14433cc48377a2f44a7b594e9de24271e523a0394e24"
    sha256 cellar: :any_skip_relocation, big_sur:        "514db9e504626e4d3b767199f1de8fcfabc64cf5efbe05ba94adb51a7b04ebca"
    sha256 cellar: :any_skip_relocation, catalina:       "071817dc82564a4f3e2a4d765af46b84b3323e917b2042cc8a446bfabd964c29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "55555d47f14ec27b0ce4000001b33636f00150a24deff686b6756950223b0c21"
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
