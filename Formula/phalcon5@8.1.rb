# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "4f44afd382bd8bc4cd98649f75f0a3f4c27458d1f7425a13071ca84d8d07ccf0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "06a24461db6fd97fe6f5ea2775cf9db3c245f3003a512c0d9e9f88f0576e8c3e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "df24bbaab4419c0b43fa9338941447fe906940fdb1ac6a77d34ec56f167f5d0f"
    sha256 cellar: :any,                 arm64_linux:       "1fafa3474fc05ece235f9f9277466f59f53c4b5340a94dbf1cf8633ee9eaf22c"
    sha256 cellar: :any,                 x86_64_linux:      "a1045b1fee93e6a7ad93d17446927eb0b1313f5f92deb25e13c909eba5012e2d"
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
