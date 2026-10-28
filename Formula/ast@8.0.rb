# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "fcd8b8b361f7ccfa01bc91341538794b3c1d6d38783ff1e500897684c9fd3cef"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "6cc9bd6d456f87e31f3387ad771d334c0b21cf5a7a38a56db563e05b2788b4d9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "c6279cc5d904fa9f1204ea7e9ceb563565467d9f98deaa170f2678d2b5c8ffc3"
    sha256 cellar: :any,                 arm64_linux:       "b7ff847cfc8fd3bb91b32cd2177448c34b92070014bc5ff4877fd17bf2f8e64b"
    sha256 cellar: :any,                 x86_64_linux:      "25d3ab9b7d35780e2dff26bbba456e28fb51af4b56664c9b2604cc17dbad9a2f"
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
