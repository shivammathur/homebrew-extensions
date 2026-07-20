# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0170290a24f3ee24153de8d9303cd0d2ae5abfe3f9333ccdd86796a22b0191c4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a2fc61c99f99d6c3ff0131f993f6115bde7dd6bf463f5cf473d4b8e8ce0bc3c0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f7eac49e16818b74090627da542ddf9c1f70d8a60f63f80794725c6115c73de8"
    sha256 cellar: :any_skip_relocation, sonoma:        "21fe910f8c827217ac7fc4ca35a81b020c2ef5d8f7361faa550192c870a3a1c9"
    sha256 cellar: :any,                 arm64_linux:   "321734ff1f34a9c17894a1539ba391e4b2dad56ef0249c4993b891cf9525e5fc"
    sha256 cellar: :any,                 x86_64_linux:  "4947e4e8d61e8414b1afa2673a837c24996405ce4dd81728c74659a0939f9251"
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
