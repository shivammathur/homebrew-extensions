# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "02d0f6699472483979230d90ef6305c08b022ca1fdf44670159c6711f313de26"
    sha256 cellar: :any,                 arm64_sequoia: "647fcd74b35089a5739a5f59fb4606331a9b86cc95c4d05d106c942baa56f71d"
    sha256 cellar: :any,                 arm64_sonoma:  "0de1154ee3a1949d6d5ddee5b446a126fafe244a1804082906cded664abf8eb8"
    sha256 cellar: :any,                 sonoma:        "7ccd43b53e894cf59bcb7356a3054e9b672aa04b06ff912d57bc08770ac69683"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "af3991dbde1b8e47c7c008344f589e118294395f8bc41408571b3eef5016c228"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "53446457b618dc24c3f3f01e167f92f474505c0f0ed68a88d82e8ce7ae7f3182"
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
