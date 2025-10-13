# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT86 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4ec8dcfd7f4cef2d57fe64e873df3e7a5ebe269c59b903e5899872e52d2ade2a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f4df7083e5a1772a729ead44415170a57c455bf274578308d15aacb87bb43358"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "72ad5c45aef9b4a93289b72f4f45df2dce4a2c0c8a5987bae6f11db6f74fff9d"
    sha256 cellar: :any_skip_relocation, sonoma:        "bfff706db12b5ee7ad182091bf44092d27950a12d0dfb89e921270e575525325"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "57a0472bc5a231ad0b83ec3c9896b1e0b053575fa7bf667fbcf6dc77a72616f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1adb68a8023f08018c150be6abdc032654567a75a2249ba7235b3f6225462af2"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
