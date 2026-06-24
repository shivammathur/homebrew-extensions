# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.16.0.tgz"
  sha256 "33db2df75a81224f710a2435f7f81c5fe1486ea1fb11579f66c4875a28b4d607"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "713c13590dc9bec797359d3e317ec9a41edeca4a6870545e23431af394f2fd95"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5fb5d63be98105defea0dc980ea6a0bf4b7d3695a3a37b10f8ea2089448a9eb5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "41653c411518c822d2061db49ddf36088badb904ca3000431b5ee26ca9e5332b"
    sha256 cellar: :any_skip_relocation, sonoma:        "a545f5e3119bdb26544a5e578dc2fb3c1972584b5d78f2459c183c87656b2204"
    sha256 cellar: :any,                 arm64_linux:   "2f16ef57c3e6af2fcd45043e17d75fca5281d12ddd858c59beb928063dd6dc42"
    sha256 cellar: :any,                 x86_64_linux:  "708d81af4a1bf38f70373d3682295c183723634eb738ffcefe9168da2f4139ae"
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
