# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.14.0.tgz"
  sha256 "9160c586227f3ae64a282eae5eec4241107087ca66689ac44498fbcd2b3f3c52"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4c31210c9fec722edc407586a1e09b701bee2a07f139fe6d3b0978655cceef76"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fb881626eebb223d642a94c07bc68b3e7e07f81eca77679f59f40a83f190dfd1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "68447a1d2c7cced3df744b7a3b0b86324fc0c20e22f0df51b5e96b99f895fce7"
    sha256 cellar: :any_skip_relocation, sonoma:        "557cd3a0ff5b24c0b4545ca613c73e077fec55cda41f52a07a9cf75e8b9a28c8"
    sha256 cellar: :any,                 arm64_linux:   "6f7d1c8e91c841fd7bcdd5253a4ef3e91a3156b07d8bdc4cdbaad08aca2fd8f4"
    sha256 cellar: :any,                 x86_64_linux:  "cd85b1441e8b34a051ccc1278fa0133b643bbc7e7e9b3b25d5c604b01fe9d31d"
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
