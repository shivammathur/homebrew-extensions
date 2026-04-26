# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT86 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  revision 1
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "82aa0e44bbc0a89b1c36dcc133b2ff84de0e0daf7d6be69f46123b1a1e654177"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2f71973104855e13d09117fcfee8274672b7c8da3b6c28a675a7ce730b04e863"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e934929f4145bed3d87813447e67c3fe5589fc2c7e44d4b7e4c204cc8b10a14c"
    sha256 cellar: :any_skip_relocation, sonoma:        "55f5d69bd915836e3bba17c8faed7086e4fb9fe2cec325d82a5949751e9907d0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "835b2961deba9d15c6649ade65ecbc49c864f2b617524760dd97c4f6ce557a8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "43b07f19faa940e36f34caf3cfd6d1bf1879e3e0c784cf8c750847080a9a8b92"
  end

  def install
    Dir.chdir "apcu-#{version}"
    inreplace "apc_persist.c", "EMPTY_SWITCH_DEFAULT_CASE()", "default: ZEND_UNREACHABLE();"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
