# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "c278d43d0b874fb859f3260eac39e92ca6f262b07a1c47f48f32d0808c7752d7"
    sha256 cellar: :any,                 arm64_sonoma:  "a441cfbcaf1c15fd92c0efdf1dc83a911dcc17d91031519cf585181e90ad1155"
    sha256 cellar: :any,                 arm64_ventura: "d8a2c699347790f9efa2a84aca286f32c04eef461ce31bd47f6656c4ec919bb8"
    sha256 cellar: :any,                 ventura:       "a8a208c9a40b32af6da1480b5a986a3877e4fd20d60d859e6e7e174c5d6a85c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6377d324bc9135fd1ce5b07793e699a032390b9475a5e56ba74bd0bee3ce01b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "179db93e7ea7d890fed779b120b6b64f3cba3140a9616ec3eb604e0db5e59d6a"
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
