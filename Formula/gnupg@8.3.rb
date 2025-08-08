# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT83 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "3cc0b65f092f8f288ae11a37f36b8c8529edb60b154e1ede9acfb80e22193212"
    sha256 cellar: :any,                 arm64_sonoma:  "cb18d25849726e4864847e600a4cc5f5e0034654320a4130d86f8f9b7004f02e"
    sha256 cellar: :any,                 arm64_ventura: "c2c0189c1e00c7a44eac64aa22b7da08dfa124b33394e7074332cf4627b1a578"
    sha256 cellar: :any,                 ventura:       "4c7b2d721cbad87d269ef833b01b102e7c8098363be97572fd084080d936cb92"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e923f30eed8c37b68b04058dc1eaca94103f2106e003139e34ce2c379a754cc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c02eb0a384780c1b48d51b59a065d00c605dea379547d114f9b4eefc1a40eb74"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Formula["gpgme"].opt_prefix}
    ]
    Dir.chdir "gnupg-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
