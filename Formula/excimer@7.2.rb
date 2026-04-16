# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT72 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3f7f3244f7289d52c0677eec26c5bfe409fe99484612834e08f94d8c8ee669e9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f5d1b017cc3e99f2ec4b0827d2975d0c94d3971047dab2794dae06dce213d3ef"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "eebce0b67c5cb70e09c1fc019a4e5b89f9de6e248b9800adba4096c9825b1fec"
    sha256 cellar: :any_skip_relocation, sonoma:        "4ff1d78617821549af66a49ce515fa6c356a79070c82ff9c04ddbba3f8ef62c6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4f599aa2b2f5e61e731d994db1e4030421aa8312c0d19e5f187da1ddfdefdbae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82aabad3accab4d26d3fbdc4fea08f6497050f6f943abf7a9b2b85d08ee5d7e0"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
