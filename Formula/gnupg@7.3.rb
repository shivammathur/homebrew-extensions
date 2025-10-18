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
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "885db49415aceec3ea82f16046be0ea2f39be0a665e94b0b3f25157d57227609"
    sha256 cellar: :any,                 arm64_sonoma:  "1b20846813cfc141aeb538089c59efca186dabb925bbeea3c735b740236c00eb"
    sha256 cellar: :any,                 arm64_ventura: "a50d8b0a13d72d79ad22919c0bf4cb5d2d0885bffc8532f6b5cc8402f098959e"
    sha256 cellar: :any,                 ventura:       "f0a4af875a21a4ed7a8643413388dfde2e35b6fd906363e0c8d7987a2b1037fb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "21417e1db351f1ffed7029fcc5e142ffe61f26e0754a3343f6ca60039c17b76a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "21126fac03ff9609140cf50d8ba8d94d5f33ee8cb152c3c57b43ee1e8e276529"
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
