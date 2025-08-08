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
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "167f1706945185eae517350e4b3a752025da73a1ec077ccb18fe2f845ecb221d"
    sha256 cellar: :any,                 arm64_sonoma:  "49c8a7f072d04458224c55c689a654d74856031cce0b673f4e62d081fe24a47c"
    sha256 cellar: :any,                 arm64_ventura: "e9bac74b8b28bdcd1d2766d7e4adbf1abe9442d55692cbdfbad762f27558672a"
    sha256 cellar: :any,                 ventura:       "fb967e5efac46a67e7472cfed6dc1f39d01d21aabcf785d66fcd862c03e125cb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "66fd986360f44fad37479bed6995f214ad51aacda8df54c7aaa077804ab9877c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa3596ab2dd1dc246d8b0dcd2b4a3547a2d8195f355b70d21a8daada47a02f33"
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
