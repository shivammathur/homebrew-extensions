# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT73 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "dd981dd3f918e75f5326db2dbdd9c85939606a98113e6f072968b9c2643819bf"
    sha256 cellar: :any,                 arm64_sonoma:  "25e4a1a5f3d373631df5908b0d59b5010768d48915f8f2e05807bbf856888f7b"
    sha256 cellar: :any,                 arm64_ventura: "fb2e6864335584f45d289b86906a4d091ee5579d3bbc22762896abb82c400e65"
    sha256 cellar: :any,                 ventura:       "3302bf48b3cccf3ba21f66ac6bea703fc5b1ba610b8d6f161f66a9389187fddc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "36e4eeb8c15fe5f5c8e184e7889b2d29f6c1c3794c30fd460e3e85597a5306b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "744afcba4675965c4ddbe5f189297e26b9bfd54da65573a7688d64d2e8c7c6c3"
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
