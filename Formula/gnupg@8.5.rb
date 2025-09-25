# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT85 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  revision 1
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "401f1fefb43a00b488fe4bb86cba1ed68caf521873f6d0b0cf0803069108f88e"
    sha256 cellar: :any,                 arm64_sonoma:  "a708fe313052595fd719e2ed921906883745c8ca66f5e8f67aa979be9b3662f5"
    sha256 cellar: :any,                 arm64_ventura: "e76132267d9b831e118e1ac3048189544305d2ff7c6ed8fa77fca5ba318b586f"
    sha256 cellar: :any,                 ventura:       "695e525666085cdd85e69f52db54c813927a08e8a4eec06a7352ea467f56bcad"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6c6182b4d9eaa66cfed3beeae5c241285b39ce017e8182bf05ac70e4142cc4ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c3857e1711f388c5c68d4be5bedd6e5f179c58e7781f126a681daf50e4ef1dc1"
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
