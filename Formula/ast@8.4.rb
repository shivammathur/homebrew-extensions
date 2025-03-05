# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT84 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e2d7a1c31ed092cd17ed81196cd6ce12d966b1655137953865991d100718a1a1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ff8000c7f3f8ac3faa05bffc8086d2ad50207eaeac35f435a6f3e2fce5022b2c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "08462d1a4bf589e7a1e17ca2b3220fc1f77d5f37f146bd66ca044bb8c79c7b64"
    sha256 cellar: :any_skip_relocation, ventura:       "e36f2de2f26f577604d1a1af0fee8a47bdc7320fc489453bde63148c418fe020"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fef07a0182e3e5de2bc141e332109bdd81a7a5bfc82cc572f5fec702a064ac51"
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
