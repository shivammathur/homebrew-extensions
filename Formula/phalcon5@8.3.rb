# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.17.0.tgz"
  sha256 "21bfc8a96bb8f9683ff64c81179d1a119b188df8eb0391db43948011a2229f90"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0c9f36ade6fbb957454c4e0c9dcd546e2e61bd5ea91629db241f00ff64699203"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8a6dd75dc2b0ccc1281fee171b4ab768e7cee6fcbf2cea24673575fcb611cb85"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b34b43d53c41270bcd7a5790fd19ab71f9c183057521b528d2ed085e60d32d7c"
    sha256 cellar: :any_skip_relocation, sonoma:        "3cea1f99f04f0fd806d3f3b8265097fa146f8d71fb30cf100c6d6f41a957a8a2"
    sha256 cellar: :any,                 arm64_linux:   "bd37b250b3d109a1f0942612c8bdeaf05e4e0670fd3e7970bd91498cad37b989"
    sha256 cellar: :any,                 x86_64_linux:  "d540050bc478d017f251e8e98db955b8704ef7778582b6cdacffc58e677b9d52"
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
