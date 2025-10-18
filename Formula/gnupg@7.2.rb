# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "032ae66b176c44503ceba81e24a8c27ff8b29c752bb471620eb7a38ff21eedcc"
    sha256 cellar: :any,                 arm64_sonoma:  "5546e10f68a6eb9ffd97c3a79986efd110db2b71743afa6bd776fa8209269657"
    sha256 cellar: :any,                 arm64_ventura: "34b5dc661d9c8f9fa951278b5f838849ffcec488643802e584bb89b95b4279c1"
    sha256 cellar: :any,                 ventura:       "e3280864a156a69b9b86c466829a0462f37c277b9bdf7cf5bad278300697643a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bf984c7d2146272e93f2deef52e4124082187341ff262a5929e49cd251689d0b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01e012539dad1c1db82f492c7b8cd34c62c8d2903d3d80aca231db4d0e2c5ae7"
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
