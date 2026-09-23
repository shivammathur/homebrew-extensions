# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.22.0.tgz"
  sha256 "da783fc9157cff533aa6f44f01134237fa1542c1310cbd06299340d4a6252979"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "f83557be50e78bf34cfcfbe57386d65cc7ecb5290fff57ece69f131b43925ec8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "9fcc08bb72d9411633621f73003a93edc487a2db0bf713d5fe89c1021647eac5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "57d6c2c4b2815e445be86b44ca542524cd2ff59524e7922c99da12005e1f396a"
    sha256 cellar: :any,                 arm64_linux:       "98d67c734ecea841887af9d3255c77b97d6b2171ccd3892fe30b7c9c42dfba37"
    sha256 cellar: :any,                 x86_64_linux:      "b844d52c401c86f04165ef9ce7efd4c01cd1ea462d3c78b6818db18270e69c11"
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
