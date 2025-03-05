# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT81 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "115579baea289b8fa519e99af68ca5f96fe3fded6e3029adba41285d1e7c50da"
    sha256 cellar: :any,                 arm64_ventura:  "7bf3630c20cee9f2e34842a5aa55c0092bc259463481fe32e865deac5b944011"
    sha256 cellar: :any,                 arm64_monterey: "bd1631c99a3c2b820e94b4e531048cac15c97da9773c47694744e29b9403ca9f"
    sha256 cellar: :any,                 arm64_big_sur:  "5cb64f76717b6169653101efcabdce7539627ff63438c34be5368d2975b5a04a"
    sha256 cellar: :any,                 ventura:        "e8a28afd64a8c91de78bbf41b811c8a65e509eab03480b4cdbdaa9274f89237b"
    sha256 cellar: :any,                 big_sur:        "b51aa40f749856b6f6fe3395876a4493b961ea37fa47c58935823a502feb0d36"
    sha256 cellar: :any,                 catalina:       "f1f6613d8139fba62879bc08f04a0c2b97726f011f7de643140c1ed52fb03aae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "135fdaa447b75abc9e34b47ad42f740c37b69386576fbe90e32de98c63e31c56"
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
