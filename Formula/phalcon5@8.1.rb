# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.3.tgz"
  sha256 "2b1983f09b56fc2779509a8ac1df776c368782538a7ef6601c0d4aef9892fe83"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "be23c9d946ea9f1dfb1e838305f4dea81fb2ece838d4d0b5f906c9da5843641d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3b30591f26218755d0d5298525e1426e690f6287d4fdb85c178941020b750d18"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8b56dfb00eb61937931b5e816f1d7a75994468bd73528ff73d6d29637ea0740c"
    sha256 cellar: :any_skip_relocation, ventura:       "9bb02797c19c052feb8fe92e5226078584d98f79b6a2b1bf87c1d48fbb891099"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c0f7dc25601cd062c08b91e7aeb902272a7931426e3fa9e54c61c1539c425c02"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
